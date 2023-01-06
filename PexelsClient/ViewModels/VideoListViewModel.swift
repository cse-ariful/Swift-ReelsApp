//
//  VideoListViewModel.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import Foundation

var videoSearchApiUrl = "https://api.pexels.com/videos/search?per_page=10&orientation=portrait&query=%@"


class VideoListViewModel : ObservableObject{
    @Published private(set) var videos:[VideoModel] = [] 
    @Published var selectedQuery:Query = Query.nature {
        didSet{
            Task.init{
                currentPage = 1
                await findVideo(query:selectedQuery)
            }
        }
    }
    @Published var isRefreshing:Bool  = false
    private var currentPage = 1
    
    init(){
        Task.init{
            await findVideo(query:Query.nature)
        }
    }
    
    func refreshVideos(){
        if isRefreshing{
            return
        }
        Task.init{
            await findVideo(query: selectedQuery)
        }
    }
    func loadNextPage(){
        if isRefreshing{
            return
        }
        currentPage = currentPage+1
        print("loading page no \(currentPage)")
        Task.init{
            await findVideo(page:self.currentPage,query: self.selectedQuery)
        }
    }
    func findVideo(page:Int=1,query:Query)async{
        do{
            if self.isRefreshing{
                return
            }
            print("loading page \(page) query \(query)")
            if self.currentPage == 1{
                DispatchQueue.main.async {
                    self.isRefreshing = true
                }
            }
            
            guard let urlRequest = PexelsApi.videos(page: page, query: query.rawValue)
                .request else {fatalError("Missing url")}
            
            
            let (data,response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.isRefreshing = false
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(PexelApiResponseBody.self, from: data)
            DispatchQueue.main.async {
                self.isRefreshing = false
                if page <= 1 {
                    self.videos = decodedData.videos
                }else{
                    self.videos.append(contentsOf:decodedData.videos)
                }
                print("self first \(self.videos[0].user.name)")
                print("url loadin \(response.url?.absoluteString)")
               
                print("item loaded total \(decodedData.videos.count)")
            }
            
            
        }catch{
            DispatchQueue.main.async {
                self.isRefreshing = false
            }
            print("Error fetching video from pexels \(error)")
        }
    }
}

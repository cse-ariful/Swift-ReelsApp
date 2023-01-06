//
//  ContentView.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = VideoListViewModel()
    
    @State var isPresented:Bool = false
    @State private var selectedCategory: Query = .nature
    
    var columns  = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView{
            
            VStack {
                
                HStack{
                    ForEach(Query.allCases.prefix(3),id: \.self){tag in
                        CategoryFilter(query: tag,isSelected : viewModel.selectedQuery==tag)
                            .onTapGesture {
                                viewModel.selectedQuery = tag
                            }
                    }
                    Menu{
                        ForEach(Query.allCases,id:\.self){q in
                            Button(q.rawValue.capitalized){
                                viewModel.selectedQuery = q
                            }
                        }
                    }label: {
                        HStack(alignment: .center){
                            Text(viewModel.selectedQuery.rawValue.capitalized)
                                .font(.caption)
                                .bold()
                            Image(systemName: "chevron.down")
                                .bold()
                        }.foregroundColor(.black.opacity(0.6))
                            .padding(.horizontal,12)
                            .padding(.vertical, 8)
                            .background(.thinMaterial)
                            .cornerRadius(8)
                    }
                    .backgroundStyle(.red)
                }
                .padding(.leading,12)
                
                
                
                
                ScrollView{
                    
                    if viewModel.isRefreshing{
                        
                        ZStack(alignment: .center){
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity,minHeight: 600)
                        
                    }else{
                        if viewModel.videos.isEmpty{
                            VStack(alignment: .center){
                                Text("No Video Available")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                
                            }.frame(maxWidth: .infinity,minHeight: 600)
                        }
                        
                        LazyVGrid(columns: columns,spacing: 12) {
                            ForEach(viewModel.videos){video in
                                NavigationLink{
                                    //                                     VideoPlayerVIew(videos: viewModel.videos)
                                }label: {
                                    VideoListItem(video: video)
                                }.backgroundStyle(.red)
                            }
                            if !viewModel.videos.isEmpty {
                                
                                HStack(alignment: .center){
                                    ProgressView()
                                }
                                .frame(minHeight: 100)
                                .onAppear{
                                    viewModel.loadNextPage()
                                }
                            }
                        }
                        .padding(.top, 12)
                        .padding(.horizontal,12)
                        
                    }
                    
                }.frame(maxWidth: .infinity)
                    .refreshable {
                        return await viewModel.findVideo(query: viewModel.selectedQuery)
                    }
                
            }
            .background(Color("AccentColor"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

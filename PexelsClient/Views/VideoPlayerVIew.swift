//
//  VideoPlayerVIew.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import SwiftUI
import AVKit

struct ReelInfo : Identifiable{
    var id = UUID().uuidString
    var player:AVPlayer?
    var video:VideoModel
    
}

struct VideoPlayerVIew: View {
    
    @State var currentIndex:Int = 0
    @State private var player : AVPlayer = AVPlayer()
    
    
    var videos : [VideoModel]
    @State var reels:[ReelInfo] = []
    @State var loading = true
    
    func initReels(){
        reels =  [previewVideo,previewVideo,previewVideo,previewVideo].map{video in
            let player = AVPlayer(url: URL(string: video.videoFiles.first!.link)!)
            
            return ReelInfo(player:player,video: video)
            
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack(alignment: .center){
                    ProgressView("Loading Reels")
                        .tint(.white)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                TabView {
                    ForEach($reels) {$reel in
                        ReelsPlayer(reel: $reel)
                            .frame(width: proxy.size.width)
                            .rotationEffect(.degrees(-90))
                            .ignoresSafeArea(.all)
                    }
                    
                }
                .rotationEffect(.init(degrees: 90))
                .frame( width: proxy.size.height)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: proxy.size.width)
                
               
            }
            
        }
        .ignoresSafeArea(.all)
        .background(Color.black.ignoresSafeArea())
//        .navigationBarHidden(true)
        .onAppear{
            initReels()
        }
        
    }
}
struct ReelsPlayer : View{
    
    @Binding var reel:ReelInfo
    @State var showMore = false
    
    var body: some View{
        ZStack{
            if let player = reel.player{
                
                CustomVideoPlayer(player: player)
                
                GeometryReader{ proxy-> Color in
                    let minY = proxy.frame(in: .global).midY
                    let size = proxy.size
                    DispatchQueue.main.async {
                        if -minY < (size.height/2) && minY < (size.height/2){
                            player.pause()
                        }else{
                            player.play()
                        }
                    }
                    return Color.clear
                    
                }
                
                VStack{
                    
                    HStack(alignment: .bottom){
                        Spacer()
                        ActionOption()
                        
                    }
                }
                .frame(maxHeight: .infinity,  alignment: .bottom)
                .padding(.all,16)
                
            }
        }
    }
    
    @ViewBuilder
    func ActionOption()-> some View{
        VStack(alignment: .leading,spacing: 12){
            let iconSize = 35.0
            Image(systemName: "heart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize,height: iconSize)
                .foregroundColor(.white)
            Text("6,257")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.bottom,16)
            Image(systemName: "message")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize,height: iconSize)
                .foregroundColor(.white)
            Text("134")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.bottom,16)
            
            Image(systemName: "paperplane")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize,height: iconSize)
                .foregroundColor(.white)
                .padding(.bottom,16)
            
            Image(systemName: "ellipsis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: iconSize,height: iconSize)
                .foregroundColor(.white)
                .padding(.bottom,16)
            Image("profile")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: iconSize,height: iconSize)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 4))
                .padding(.bottom,16)
        }
    }
}

struct VideoPlayerVIew_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerVIew(videos: [previewVideo,previewVideo,previewVideo])
    }
}

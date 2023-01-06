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
    
    @State var reels:[ReelInfo]
    var videos : [VideoModel]
    
    init(videos:[VideoModel]){
        self.videos = videos
        reels = videos.map{video in
            let player = AVPlayer(url: URL(string: video.videoFiles.first!.link)!)
            
            return ReelInfo(player:player,video: video)
            
        }
    }
    
    var body: some View {
        GeometryReader{proxy in
//            let size = proxy.size
            TabView(selection: $currentIndex){
                ForEach($reels) {$reel in
                    ReelsPlayer(reel: $reel)
                    
                }
            }
//            .rotationEffect(.init(degrees:90))
//            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
//            .frame(width: size.width)
            //            .ignoresSafeArea(.all)
            
        }.navigationBarHidden(true)
    }
}
struct ReelsPlayer : View{
    
    @Binding var reel:ReelInfo
    
    var body: some View{
        ZStack{
            if let player = reel.player{
                
                CustomVideoPlayer(player: player)
                
            }
        }
    }
}

struct VideoPlayerVIew_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerVIew(videos: [previewVideo,previewVideo,previewVideo])
    }
}

//
//  VideoListItem.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/5/23.
//

import SwiftUI

struct VideoListItem: View {
    let video : VideoModel
    var body: some View {
       
        ZStack {
            ZStack(alignment: .bottomLeading){
                AsyncImage(url: URL(string: video.image)){image in
                    image
                        .resizable()
                        .aspectRatio(0.6,contentMode: ContentMode.fill)
                        .transition(.opacity.animation(.easeInOut(duration: 1)))
                        .cornerRadius(20)
                }placeholder: {
                    Rectangle()
                        .foregroundColor(.gray.opacity(0.2))
                        .aspectRatio(0.6,contentMode: ContentMode.fill)
                        .cornerRadius(20)
                }
                VStack(alignment: .leading){
                    Text("\(video.duration) sec")
                        .font(.caption)
                        .bold()
                    Text("By \(video.user.name)")
                        .font(.caption)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)
                .shadow(radius: 20)
                .padding()
            }
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title)
                .padding( )
                .background(.ultraThinMaterial.opacity(0.7))
                .cornerRadius(50)
        }
    }
}

struct VideoListItem_Previews: PreviewProvider {
    static var previews: some View {
        VideoListItem(video: previewVideo)
    }
}

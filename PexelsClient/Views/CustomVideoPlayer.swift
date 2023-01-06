//
//  CustomVideoPlayer.swift
//  PexelsClient
//
//  Created by Ariful Jannat Arif on 1/6/23.
//

import Foundation
import AVKit
import SwiftUI

struct CustomVideoPlayer : UIViewControllerRepresentable{
    
    var player : AVPlayer
    
    func makeUIViewController(context : Context) -> AVPlayerViewController{
       
        let controller = AVPlayerViewController()
        
        controller.player = player
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspectFill
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
            
    }
}

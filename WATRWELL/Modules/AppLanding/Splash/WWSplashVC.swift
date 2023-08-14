//
//  WWSplashVC.swift
//  WATRWELL
//
//  Created by Abhishek Singh on 10/08/23.
//

import Foundation
import AVFoundation
import RxCocoa

final class WWSplashVC: WWBaseVC {
    
    // Outlets
    
    // Properties
    private var player : AVPlayer?
    private var playerLayer : AVPlayerLayer?

    // Overriden functions
    override func setupViews() {
        playVideo()
    }
}

// MARK: - ViewController life cycle methods
extension WWSplashVC {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
}

private extension WWSplashVC {
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "WATRWELL_INTRO", ofType:"mp4") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspectFill
        player?.automaticallyWaitsToMinimizeStalling = true
        if let layer = playerLayer{
            view.layer.insertSublayer(layer, at: 0)
            player?.playImmediately(atRate: 1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.25, execute: {
            WWRouter.shared.setRootScene()
        })
    }
}


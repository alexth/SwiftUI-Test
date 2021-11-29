//
//  PlayerView.swift
//  SwiftUI Test
//
//  Created by Alex Golub on 23.11.2021.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {}
    
    func makeUIView(context: Context) -> UIView { LoginPlayerView(frame: .zero) }
}

class LoginPlayerView: UIView {
    
    private var playerLooper: AVPlayerLooper?
    private let playerLayer = AVPlayerLayer()
    private let player = AVQueuePlayer()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let fileUrl = Bundle.main.url(forResource: "video", withExtension: "mp4") else {
            return
        }
        
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.play()
        
        registerForEnteringForeground()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    // MARK: - Notifications
    private func registerForEnteringForeground() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleEnteringForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func handleEnteringForeground() { player.play() }
}

//
//  LoopingPlayer.swift
//  tht-toktok
//
//  Created by Iuri Chiba on 05/12/22.
//

import UIKit
import AVFoundation

final class LoopingPlayerView: UIView {
    
    // MARK: - Instances
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private var player: AVQueuePlayer? {
        get { return playerLayer.player as? AVQueuePlayer }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer {
        let layer = layer as! AVPlayerLayer
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private var looper: AVPlayerLooper?
    
    
    // MARK: - Actions
    func play(fromURL url: URL) {
        let playerItem = AVPlayerItem(url: url)
        
        DispatchQueue.main.async { [weak self] in
            let player = AVQueuePlayer(items: [playerItem])
            let looper = AVPlayerLooper(player: player, templateItem: playerItem)
            self?.player = player
            self?.looper = looper
            player.play()
        }
    }
    
}

// MARK: - IBDesignable Resources
@IBDesignable
extension LoopingPlayerView {
    
    override func prepareForInterfaceBuilder() {
        self.addBackgroundPlaceholder()
    }
    
    private func addBackgroundPlaceholder() {
        let dynamicBundle = Bundle(for: type(of: self))
        let image = UIImage(named: "video-snapshot", in: dynamicBundle, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(origin: .zero, size: self.frame.size)
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
    }
    
}

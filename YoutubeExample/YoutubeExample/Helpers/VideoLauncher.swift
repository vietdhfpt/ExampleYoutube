//
//  VideoLauncher.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/11/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {

    let activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.startAnimating()
        return activityView
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    var asset: AVAsset?
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    
    var isPlaying = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView { isSuccess in
            if isSuccess {
                activityIndicatorView.stopAnimating()
            }
        }
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backgroundColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPlayerView(completion: ((_ isSuccess: Bool) -> Void)) {
        if let urlString = URL(string: "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726") {
            
            asset = AVAsset(url: urlString)
            
            let assetKeys = [
                "playable",
                "hasProtectedContent"
            ]
            
            playerItem = AVPlayerItem(asset: asset!,
                                      automaticallyLoadedAssetKeys: assetKeys)
            
            playerItem?.addObserver(self,
                                   forKeyPath: #keyPath(AVPlayerItem.status),
                                   options: [.old, .new],
                                   context: nil)
            
            // Associate the player item with the player
            player = AVPlayer(playerItem: playerItem)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame

        }
    }
    
    @objc func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            
            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            // Switch over the status
            switch status {
            case .readyToPlay:
                activityIndicatorView.stopAnimating()
                controlsContainerView.backgroundColor = .clear
                player?.play()
                pausePlayButton.isHidden = false
                isPlaying = true
            case .failed:
                break
            case .unknown:
                break
            }
        }
    }
}

class VideoLauncher: NSObject {
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16 // Size for video the aspect radio of HD videos is 9 / 16
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                // Hide status bar
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            }
        }
    }
}

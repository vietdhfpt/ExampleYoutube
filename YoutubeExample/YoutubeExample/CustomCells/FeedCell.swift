//
//  FeedCell.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/9/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    var videos: [Video]?
    let videoCell = "VideoCell"
    
    override func setupViews() {
        super.setupViews()
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        setupCollectionView()
        fetchVideos()
    }
    
    func setupCollectionView() {
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: self.videoCell)
    }
    
    func fetchVideos() {
        ApiService.shared.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FeedCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.videoCell, for: indexPath) as! VideoCell
        guard let videos = self.videos, indexPath.row < videos.count else { return cell }
        cell.video = videos[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FeedCell: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FeedCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.bounds.width - 32) * 9 / 16
        return CGSize(width: self.bounds.width, height: height + 16 + 88)
    }
}

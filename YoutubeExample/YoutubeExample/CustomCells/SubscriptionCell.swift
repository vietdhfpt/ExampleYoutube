//
//  SubscriptionCell.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/9/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.shared.fetchSubscriptionVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}

//
//  ApiService.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/8/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let shared = ApiService()
    
    func fetVideos(completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dict in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    video.numberOfViews = dict["number_of_views"] as? NSNumber
                    
                    let channelDict = dict["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.profileImageName = channelDict["profile_image_name"] as? String
                    channel.name = channelDict["name"] as? String
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
}

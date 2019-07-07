//
//  Setting.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/5/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

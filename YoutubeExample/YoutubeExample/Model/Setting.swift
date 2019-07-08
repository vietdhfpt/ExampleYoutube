//
//  Setting.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/5/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import Foundation

enum SettingsName: String {
    case Settings = "Settings"
    case Term = "Term & Privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
}

class Setting: NSObject {
    let name: SettingsName
    let imageName: String
    
    init(name: SettingsName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

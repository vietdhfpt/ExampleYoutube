//
//  SettingCell.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/5/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    var setting: Setting? {
        didSet {
            guard let setting = setting else { return }
            nameLabel.text = setting.name.rawValue
            iconImageView.image = UIImage(named: setting.imageName)?.withRenderingMode(.alwaysTemplate)
            iconImageView.tintColor = .darkGray
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            print(self.isHighlighted)
            backgroundColor = self.isHighlighted ? .darkGray : .white
            nameLabel.textColor = self.isHighlighted ? .white : .black
            iconImageView.tintColor = self.isHighlighted ? .white : .darkGray
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]-8-|", views: iconImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]|", views: iconImageView)
    }
}

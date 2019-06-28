//
//  MenuBarCell.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 6/28/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            iconImageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:[v0(25)]", views: iconImageView)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}

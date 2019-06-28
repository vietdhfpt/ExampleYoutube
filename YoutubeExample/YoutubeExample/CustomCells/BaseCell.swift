//
//  BaseCell.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 6/28/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}

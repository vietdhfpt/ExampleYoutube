//
//  HomeViewController.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 6/26/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        setupMenuBar()
    }

    private func setupDefault() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = "Home"
        titleLabel.font = .systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
}


extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.bounds.width - 32) * 9 / 16
        return CGSize(width: self.view.bounds.width, height: height + 16 + 68)
    }
}

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
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launch = SettingsLauncher()
        launch.homeController = self
        return launch
    }()
    
    var videos: [Video] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchVideos()
        setupMenuBar()
        setupCollectionView()
        setupNavBarButtons()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavBarButtons() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = " Home"
        titleLabel.font = .systemFont(ofSize: 18)
        
        navigationItem.titleView = titleLabel
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    @objc func handleSearch() {
        
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    private func setupMenuBar() {
        self.navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    internal func showController(setting: Setting) {
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = .white
        dummyViewController.navigationItem.title = setting.name.rawValue
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
    private func fetchVideos() {
        ApiService.shared.fetVideos { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}

extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        guard indexPath.row < videos.count else { return cell }
        cell.video = videos[indexPath.row]
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.bounds.width - 32) * 9 / 16
        return CGSize(width: self.view.bounds.width, height: height + 16 + 88)
    }
}

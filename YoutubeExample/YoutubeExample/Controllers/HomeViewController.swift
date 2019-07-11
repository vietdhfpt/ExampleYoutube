//
//  HomeViewController.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 6/26/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeViewController = self
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launch = SettingsLauncher()
        launch.homeController = self
        return launch
    }()
    
    var videos: [Video] = []
    let feedCell = "FeedCell"
    let trendingCell = "TrendingCell"
    let subscriptionCell = "SubscriptionCell"
    let accountCell = "AccountCell"
    let titles: [String] = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavBarButtons()
        setupMenuBar()
    }

    private func setupCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: self.feedCell)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: self.trendingCell)
        collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: self.subscriptionCell)
        collectionView.register(AccountCell.self, forCellWithReuseIdentifier: self.accountCell)
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
    }
    
    private func setupNavBarButtons() {
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.textColor = .white
        titleLabel.text = " Home"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        navigationItem.titleView = titleLabel
        
        let searchButton = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
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
        
        menuBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    @objc func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    internal func showController(setting: Setting) {
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = .white
        dummyViewController.navigationItem.title = setting.name.rawValue
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.navigationController?.pushViewController(dummyViewController, animated: true)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = " " + self.titles[index]
        }
    }
}

// MARK: - Handle scrolling
extension HomeViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        
        setTitleForIndex(index: Int(index))
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier: String
        switch indexPath.item {
        case 0:
            identifier = self.feedCell
        case 1:
            identifier = self.trendingCell
        case 2:
            identifier = self.subscriptionCell
        default:
            identifier = self.accountCell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50) // Minus 50 is height of menu bar
    }
}

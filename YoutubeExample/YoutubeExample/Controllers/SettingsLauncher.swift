//
//  SettingsLauncher.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 7/4/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let blackView = UIView()
    let cellId = "CellId"
    let cellHeight: CGFloat = 50
    var homeController: HomeViewController?
    
    let settings = [Setting(name: .Settings, imageName: "settings"),
                    Setting(name: .Term, imageName: "privacy"),
                    Setting(name: .Feedback, imageName: "feedback"),
                    Setting(name: .Help, imageName: "help"),
                    Setting(name: .SwitchAccount, imageName: "switch_account"),
                    Setting(name: .Cancel, imageName: "cancel")]
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func showSettings() {
        // Show menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSettings)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(self.settings.count) * cellHeight
            let y = window.frame.height - height
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.bounds.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: window.bounds.width, height: height)
            }, completion: nil)
        }
    }
    
    @objc func handleDismissSettings() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.bounds.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    func handleDismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.bounds.width, height: self.collectionView.frame.height)
            }
        }) { isCompleted in
            if isCompleted {
                if setting.name != .Cancel {
                    self.homeController?.showController(setting: setting)
                }
            }
        }
    }

}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = self.settings[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.row]
        self.handleDismiss(setting: setting)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: self.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

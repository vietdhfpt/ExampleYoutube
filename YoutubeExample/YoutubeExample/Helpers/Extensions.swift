//
//  Extensions.swift
//  YoutubeExample
//
//  Created by Do Hoang Viet on 6/28/19.
//  Copyright © 2019 Do Hoang Viet. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .init(), metrics: nil, views: viewsDictionary))
    }
}

class CustomImageView: UIImageView {
    let imageCache = NSCache<NSString, UIImage>()
    
    func loadImageUsingUrlString(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = self.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let data = data else { return }
            
            if let imageToCache = UIImage(data: data) {
                self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = imageToCache
                }
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            }.resume()
    }
}

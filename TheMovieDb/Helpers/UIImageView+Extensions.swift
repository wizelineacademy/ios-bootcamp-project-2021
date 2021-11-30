//
//  UIImageView+Extensions.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func setImage(path: String?) {
        guard let path = path, let url = URL(string: Constants.imageBaseUrl + path) else {
            let image = UIImage(named: "ImagePlaceholder")
            self.image = image
            return
        }
        setImage(from: url)
    }
    
    func setImage(from url: URL, mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) {
            self.image = imageFromCache as? UIImage
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let imageToCache = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                self.image = imageToCache
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
            }
        }.resume()
    }
}

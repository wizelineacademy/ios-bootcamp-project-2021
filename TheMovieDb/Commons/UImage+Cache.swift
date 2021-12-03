//
//  UImage+Cache.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 30/11/21.
//

import UIKit
var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImage(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            imageCache.setObject(image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()

    }
}

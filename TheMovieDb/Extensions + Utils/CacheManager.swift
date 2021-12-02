//
//  CacheManager.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 01/12/21.
//

import UIKit

// MARK: - Cache Manager for the Image

class CacheManager {
    
    private let imageQueue = DispatchQueue(label: Constants.cacheDispatchQueue)
    
    static let shared = CacheManager()
    let cache = NSCache<NSString, UIImage>()
    
    init() {
        
    }
    
    func cacheImage(image: UIImage, identifier: String) {
        imageQueue.async {
            self.cache.setObject(image, forKey: identifier as NSString)
        }
    }
    
    func getImage(identifier: String) -> UIImage? {
        var image: UIImage?
        imageQueue.async {
            image = self.cache.object(forKey: identifier as NSString)
        }
        return image
    }
    
}

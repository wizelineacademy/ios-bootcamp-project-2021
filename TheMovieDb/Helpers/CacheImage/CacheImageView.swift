//
//  CachedImageView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/14/21.
//

import UIKit

// MARK: class inheritance from UIImageView to has a cache of the image without KingFisher

class CacheImageView: UIImageView {
  
  var imageCache: NSCache<NSString, DiscardableImageCacheItem> {
    let cache = NSCache<NSString, DiscardableImageCacheItem>()
    cache.countLimit = 20
    cache.totalCostLimit = 200
    return cache
  }
  var activity: UIActivityIndicatorView = {
    let a = UIActivityIndicatorView()
    a.style = .large
    return a
  }()
  
  private var urlStringForChecking: String?
  var emptyImage: UIImage?
  
  public func loadImage(urlString: String?, completion: (() -> Void)? = nil) {
    self.showLoading(view: &activity)
    image = nil
    
    guard urlString != nil else {
      image = emptyImage
      stopLoading(view: &activity)
      return
    }
    
    self.urlStringForChecking = urlString
    guard let urlKey = urlString as NSString?, let url = URL(string: urlString!) else { return }
    
    if let cachedItem = imageCache.object(forKey: urlKey) {
      image = cachedItem.image
      completion?()
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in

      guard let data = data, error == nil else { return }
      guard let self = self else { return }

      DispatchQueue.main.async {
        if let imageData = UIImage(data: data)?.jpegData(compressionQuality: 0.5) {
          if let newImageSmaller = UIImage(data: imageData) {
            let cacheItem = DiscardableImageCacheItem(image: newImageSmaller)
            self.imageCache.setObject(cacheItem, forKey: urlKey)
            if urlString == self.urlStringForChecking {
              self.image = newImageSmaller
              self.stopLoading(view: &self.activity)
              completion?()
            }
          }
        }
      }
    }
    task.resume()
  }
  
}

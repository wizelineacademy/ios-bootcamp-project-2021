//
//  CachedImageView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/14/21.
//

import UIKit

// MARK: class inheritance from UIImageView to has a cache of the image without KingFisher

class CacheImageView: UIImageView {
  
  public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
  
  private var urlStringForChecking: String?
  var emptyImage: UIImage?
  
  public func loadImage(urlString: String?, completion: (() -> Void)? = nil) {
    image = nil
    
    guard urlString != nil else {
      image = emptyImage
      return
    }
    
    self.urlStringForChecking = urlString
    guard let urlKey = urlString as NSString?, let url = URL(string: urlString!) else { return }
    
    if let cachedItem = CacheImageView.imageCache.object(forKey: urlKey) {
      image = cachedItem.image
      completion?()
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
      guard let data = data, error == nil else { return }
      
      DispatchQueue.main.async {
        if let imageData = UIImage(data: data)?.jpegData(compressionQuality: 0.5) {
          if let newImageSmaller = UIImage(data: imageData) {
            let cacheItem = DiscardableImageCacheItem(image: newImageSmaller)
            CacheImageView.imageCache.setObject(cacheItem, forKey: urlKey)
            if urlString == self?.urlStringForChecking {
              self?.image = newImageSmaller
              completion?()
            }
          }
        }
      }
    }
    task.resume()
  }
}

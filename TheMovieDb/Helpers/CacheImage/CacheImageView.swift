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

  public var shouldUseEmptyImage = true
  
  private var urlStringForChecking: String?
  var emptyImage: UIImage?
  
  public func loadImage(urlString: String?, completion: (() -> Void)? = nil) {
    image = nil
    
    if urlString == nil {
      if shouldUseEmptyImage { image = emptyImage }
      return
    }
    
    self.urlStringForChecking = urlString
    guard let urlKey = urlString as NSString? else { return }

    guard let url = URL(string: urlString ?? "") else { return }
    
    if let cachedItem = CacheImageView.imageCache.object(forKey: urlKey) {
      image = cachedItem.image
      completion?()
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
      guard let data = data, error == nil else { fatalError("the image doesn't exist") }
      
      DispatchQueue.main.async {
        if let image = UIImage(data: data) {
          let cacheItem = DiscardableImageCacheItem(image: image)
          CacheImageView.imageCache.setObject(cacheItem, forKey: urlKey)
          if urlString == self?.urlStringForChecking {
            self?.image = image
            completion?()
          }
        }
      }
    }
    task.resume()
  }
}

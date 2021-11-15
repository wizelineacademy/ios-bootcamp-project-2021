//
//  CachedImageView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/14/21.
//

import UIKit

class CacheImageView: UIImageView {
  
  public static let imageCache = NSCache<NSString, DiscardableImageCacheItem>()
  public var shouldUseEmptyImage = true
  
  private var urlStringForChecking: String?
  private var emptyImage: UIImage?
  
  public func loadImage(urlString: String, completion: (() -> Void)? = nil) {
    image = nil
    
    self.urlStringForChecking = urlString
    let urlKey = urlString as NSString
    
    if let cachedItem = CacheImageView.imageCache.object(forKey: urlKey) {
      image = cachedItem.image
      completion?()
      return
    }
    
    guard let url = URL(string: urlString) else {
      if shouldUseEmptyImage {
        image = emptyImage
      }
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
      guard let data = data, error == nil else {return}
      
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

open class DiscardableImageCacheItem: NSObject, NSDiscardableContent {
  
  private(set) public var image: UIImage?
  var accessCount: UInt = 0
  
  public init(image: UIImage) {
    self.image = image
  }
  
  public func beginContentAccess() -> Bool {
    if image == nil {
      return false
    }
    
    accessCount += 1
    return true
  }
  
  public func endContentAccess() {
    if accessCount > 0 {
      accessCount -= 1
    }
  }
  
  public func discardContentIfPossible() {
    if accessCount == 0 {
      image = nil
    }
  }
  
  public func isContentDiscarded() -> Bool {
    return image == nil
  }
  
}

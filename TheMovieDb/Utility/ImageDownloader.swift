//
//  ImageDownloader.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 29/11/21.
//

import UIKit
import os

struct ImageDownloader {
    private static let logger = Logger(subsystem: Constants.subsystemName, category: "ImageDownloader")
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            var downloadedImage: UIImage?
            
            if let error = error {
                logger.error("\(error.localizedDescription)")
                return
            }
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
    static func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
}

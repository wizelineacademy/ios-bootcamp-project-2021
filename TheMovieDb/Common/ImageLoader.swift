//
//  ImageLoader.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 30/11/21.
//

import Foundation
import UIKit

protocol ImageProvider {
    func getImage(withURL url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageLoader: ImageProvider {
    
    private let cache: Cache<String, UIImage>
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared, cache: Cache<String, UIImage> = Cache<String, UIImage>()) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache[url.absoluteString] {
            completion(cached)
        } else {
            urlSession.dataTask(with: URLRequest(url: url)) { [weak self] data, _, _ in
                if let data = data,
                   let image = UIImage(data: data) {
                    self?.cache[url.absoluteString] = image
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
    
}

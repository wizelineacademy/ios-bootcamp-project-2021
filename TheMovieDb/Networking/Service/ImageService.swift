//
//  ImageService.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 15/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromNetwork(withURL url: URL) {
        
        if let image = MovieConst.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = image
            return
        } else {
            let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                var downloadedImage: UIImage?
                
                if let data = data {
                    downloadedImage = UIImage(data: data)
                }
                
                if downloadedImage != nil {
                    MovieConst.imageCache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                }
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
                
            }
            
            dataTask.resume()
        }
    }
    
}

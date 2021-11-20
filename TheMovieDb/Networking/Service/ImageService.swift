//
//  ImageService.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 15/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromNetwork(withURL url: URL?) {
        
        guard let url = url else { return }
        
        if let image = MovieConst.imageCache.object(forKey: url.absoluteString as NSString) {
            self.image = image
            return
        } else {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
                if self.imageOnError(error: error) {
                    return
                } else {
                    self.imageInData(data: data, response: response, url: url)
                }
            }
            dataTask.resume()
        }
    }
    
    private func imageOnError(error: Error?) -> Bool {
        if let error = error {
            Log.imageService(error).description
            DispatchQueue.main.async {
                self.image = #imageLiteral(resourceName: "default")
            }
            return true
        }
        return false
    }
    
    private func imageInData(data: Data?, response: URLResponse?, url: URL) {
        if let data = data {
            let downloadedImage = UIImage(data: data)
            if downloadedImage != nil {
                MovieConst.imageCache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    Log.generalInfo("image not found. Status :\(httpResponse.statusCode)").description
                }
                
            }
        }
    }
    
}

//
//  ImageNSCache.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 01/12/21.
//

import UIKit

var imageNSCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func getImageWithNSCache(withURL url: URL?) {
        
        guard let url = url else { return }
        if let image = imageNSCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                self.image = image
            }
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
            print(error)
            return true
        }
        return false
    }
    
    private func imageInData(data: Data?, response: URLResponse?, url: URL) {
        if let data = data {
            let downloadedImage = UIImage(data: data)
            if downloadedImage != nil {
                DispatchQueue.main.async {
                    imageNSCache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                    self.image = downloadedImage
                }
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print("httpResponse \(httpResponse)")
                }
                DispatchQueue.main.async {
                    let defaultImage: UIImage? = UIImage(named: "error")
                    self.image = defaultImage
                    imageNSCache.setObject(defaultImage ?? UIImage(), forKey: url.absoluteString as NSString)
                }
                
            }
        }
    }
    
}

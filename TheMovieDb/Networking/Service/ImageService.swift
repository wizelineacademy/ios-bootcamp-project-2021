//
//  ImageService.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 15/11/21.
//

import UIKit
var imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func setImageFromNetwork(withURL url: URL?) {
        
        guard let url = url else { return }
        // if there is url key saved in cache the image will be returned
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
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
    
    // If there is a error the image returned will be default on the cell
    private func imageOnError(error: Error?) -> Bool {
        if let error = error {
            Log.imageService(error).description
            DispatchQueue.main.async {
                self.image = UIImage(named: InterfaceConst.defaultImage) ?? UIImage()
            }
            return true
        }
        return false
    }
    
    // Here the is two possibilities: data is a image or just another kind of pase
    private func imageInData(data: Data?, response: URLResponse?, url: URL) {
        if let data = data {
            let downloadedImage = UIImage(data: data)
            // if the downloadedImage is not nil will be the image for the cell and it will be saved in cache
            if downloadedImage != nil {
                DispatchQueue.main.async {
                    imageCache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                    self.image = downloadedImage
                }
            } else {
                // if there is not error and the response is not a image, default image will be returned and saved in cache
                if let httpResponse = response as? HTTPURLResponse {
                    Log.generalInfo("image not found. Status :\(httpResponse.statusCode)").description
                }
                DispatchQueue.main.async {
                    let defaultImage: UIImage? = UIImage(named: InterfaceConst.defaultImage)
                    self.image = defaultImage
                    imageCache.setObject(defaultImage ?? UIImage(), forKey: url.absoluteString as NSString)
                }
                
            }
        }
    }
    
}

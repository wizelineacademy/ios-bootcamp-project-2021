//
//  Extensions + UIImageView.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 14/11/21.
//

import Foundation
import UIKit

extension UIImageView {

func imageFetcher(url: URL, contentMode mode:  UIView.ContentMode = .scaleAspectFit) {

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                return
                }
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }.resume()
    }

}

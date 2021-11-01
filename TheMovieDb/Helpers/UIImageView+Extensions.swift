//
//  UIImageView+Extensions.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

extension UIImageView {
    func setImage(path: String?) {
        let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
        guard let path = path, let url = URL(string: imageBaseUrl + path) else {
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}

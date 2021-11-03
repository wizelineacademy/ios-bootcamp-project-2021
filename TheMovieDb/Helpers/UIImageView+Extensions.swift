//
//  UIImageView+Extensions.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

extension UIImageView {
    func setImage(path: String?) {
        
        guard let path = path, let url = URL(string: Constants.imageBaseUrl + path) else {
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}

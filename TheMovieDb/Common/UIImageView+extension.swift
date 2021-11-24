//
//  UIImageView+extension.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 23/11/21.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: ((UIImage) -> Void)?) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?(image)
                    }
                }
            }
        }
    }
}

//
//  Extensions.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 25/11/21.
//

import Foundation
import UIKit

// MARK: - Extension to reformat the date

extension String {
    func readableDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd MMMM yyyy" // readable format
            return dateFormatter.string(from: date)
        } else {
            return self
        }
    }
}

// MARK: - Extension to fetch de Image

extension UIImageView {
    func downloadedFrom(url: URL) {
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
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }

}

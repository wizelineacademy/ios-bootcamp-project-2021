//
//  Extensions.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 25/11/21.
//

import Foundation

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

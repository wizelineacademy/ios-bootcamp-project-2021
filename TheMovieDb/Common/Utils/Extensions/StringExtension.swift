//
//  StringExtension.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/11/21.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}

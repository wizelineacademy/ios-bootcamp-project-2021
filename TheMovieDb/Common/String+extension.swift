//
//  String+extension.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 11/11/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

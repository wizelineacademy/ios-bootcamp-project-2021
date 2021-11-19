//
//  String+Extensions.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 18/11/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

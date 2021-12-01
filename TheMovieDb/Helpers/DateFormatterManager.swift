//
// DateFormatterManager.swift//  TheMovieDb
//
//  Created by developer on 24/11/21.
//

import Foundation

struct DateFormatterManager {
    static func formatToReadableString(dateString: String) -> String? {
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYY-MM-DD"
        guard let dateFromString = dateFormmatter.date(from: dateString) else { return nil }
        dateFormmatter.dateStyle = .full
        let readableString = dateFormmatter.string(from: dateFromString)
        return readableString
    }
}

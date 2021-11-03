//
//  Encodable+Extensions.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation

extension Encodable {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

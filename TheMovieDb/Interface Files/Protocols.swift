//
//  Protocols.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation

protocol CellIdentifierProtocol {
   static var identifierToDeque: String { get }
}

extension CellIdentifierProtocol {
    static var identifierToDeque: String {
        return String(describing: self)
    }
}

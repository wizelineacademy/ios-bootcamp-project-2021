//
//  Reusable.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

protocol Reusable: AnyObject {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: self)
    }
}

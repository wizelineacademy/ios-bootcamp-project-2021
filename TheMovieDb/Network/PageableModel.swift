//
//  PageableModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation

public protocol PageableModel {
    var page: Int { get set }
    mutating func nextPage()
    mutating func clearPages()
}

extension PageableModel {
    var page: Int {
        return 1
    }
    
    mutating func nextPage() {
        page += 1
    }
    
    mutating func clearPages() {
        page = 1
    }
}

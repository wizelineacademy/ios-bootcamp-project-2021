//
//  SearchableModel.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation

public protocol SearchableModel {
    var search: String { get set }
    mutating func searchText(_ search: String)
}

extension SearchableModel {
    
    mutating func searchText(_ search: String) {
        self.search = search
    }
}

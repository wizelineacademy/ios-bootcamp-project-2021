//
//  HTTPMethod.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 03/11/21.
//

import Foundation

final class MovieDBNetworkConfig {

    static let shared = MovieDBNetworkConfig()

    private (set) var apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    var baseAPIURLString: String {
        return "https://api.themoviedb.org"
    }

    init() {}

    func configure(with apiKey: String) {
        self.apiKey = apiKey
    }

}

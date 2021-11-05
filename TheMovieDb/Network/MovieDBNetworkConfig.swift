//
//  HTTPMethod.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 03/11/21.
//

import Foundation

final class MovieDBNetworkConfig {

    static let shared = MovieDBNetworkConfig()

    private (set) var apiKey = ""
    private (set) var readAccessToken = ""

    var baseAPIURLString: String {
        return "https://api.themoviedb.org"
    }

    init() {}

    func configure(with apiKey: String, and readAccessToken: String) {
        self.apiKey = apiKey
        self.readAccessToken = readAccessToken
    }

}

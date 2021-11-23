//
//  ConfigurationItem.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 04/11/21.
//

import Foundation

struct ConfigurationWelcome: Decodable {
    let image: ConfigurationImage
    let changeKeys: [String]

    enum CodingKeys: String, CodingKey {
        case image = "images"
        case changeKeys = "change_keys"
    }
}

struct ConfigurationImage: Decodable {
    let secureBaseURL: String
    let backdropSizes: [String]
    let posterSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case posterSizes = "poster_sizes"
    }
    
    func getSecureBasePosterURL() -> String {
        guard !backdropSizes.isEmpty else {
            return ""
        }
        let posterIndex = backdropSizes.firstIndex(where: { $0 == Constants.defaultPosterSize }) ?? 0
        return self.secureBaseURL + backdropSizes[posterIndex]
    }
}

//
//  ImageForMovie.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 01/12/21.
//

import Foundation

final class ImageForMovie {
    private let baseURL = "https://image.tmdb.org/t/p/w500"
    
    func createURLForImage(path: String) -> String {
        let urlString = baseURL + path
        return urlString
    }
}

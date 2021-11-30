//
//  MoviesHomeAPIManagerMock.swift
//  TheMovieDbTests
//
//  Created by developer on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesHomeAPIManagerMock: MoviesHomeAPIDataManagerProtocol {
    func requestMovies<T>(value: T.Type, request: Request, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
        MovieDbAPI.request(value: T.self, request: request) {  result in
            switch result {
            case .success(let result):
            guard let listOfMovies = result else { return }
                completion(.success(listOfMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

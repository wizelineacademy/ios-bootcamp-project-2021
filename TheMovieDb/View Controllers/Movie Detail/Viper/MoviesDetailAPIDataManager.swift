//
//  MoviesDetailAPIManager.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import Foundation

final class MoviesDetailAPIDataManager: MoviesDetailAPIDataManagerProtocol {
    func requestSimilarMovies<T>(value: T.Type, request: Request, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
       
        MovieDbAPI.request(value: T.self, request: request) { result in
            switch result {
            case .success(let similarMovies):
                guard let list = similarMovies else { return }
                completion(.success(list))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func requestMovieDetail<T>(value: T.Type, request: Request, completion: @escaping (Result<T?, Error>) -> Void) where T: Decodable {
        
        MovieDbAPI.request(value: T.self, request: request) { result in
            switch result {
            case .success(let result):
                guard let movieDetail = result else { return }
                completion(.success(movieDetail))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}

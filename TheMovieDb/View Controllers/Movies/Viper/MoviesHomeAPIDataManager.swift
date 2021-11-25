//
//  MoviesHomeAPIDataManager.swift
//  TheMovieDb
//
//  Created by developer on 24/11/21.
//

import Foundation

final class MoviesHomeAPIDataManager: MoviesHomeAPIDataManagerProtocol {
    
    var interactor: MoviesHomeInteractorOutputProtocol?
    
    func requestMovies<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void ) {
       
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

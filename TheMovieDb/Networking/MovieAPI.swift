//
//  MovieAPI.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/10/21.
//

import Foundation

final class MovieAPI: APIMoviesProtocol {
    
    static let shared = MovieAPI()
    private let apiService = APIService()
    
    public func fetchData<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters = APIParameters(), completion: @escaping(Result<T, Error>) -> Void) {
        apiService.getResponse(endPoint: endPoint, with: parameters, completion: { (response: Result<T, Error>) in
            completion(response)
        })
    }
    
}

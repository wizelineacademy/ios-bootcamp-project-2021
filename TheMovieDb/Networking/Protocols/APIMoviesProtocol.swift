//
//  APIDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Combine

protocol APIMoviesProtocol {
    func fetchData<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters) -> AnyPublisher<T, APIRequestError>
}

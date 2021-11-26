//
//  APIDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Combine

protocol APIMoviesProtocol: AnyObject {
    func fetchData<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters, completion: @escaping((Result<T, Error>) -> Void))
    func fetchDataCombine<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters) -> AnyPublisher<T, APIRequestError>
}

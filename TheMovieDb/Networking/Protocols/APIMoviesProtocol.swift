//
//  APIDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Foundation

protocol APIMoviesProtocol: AnyObject {
    func fetchData<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters, completion: @escaping((Result<T, Error>) -> Void))
}

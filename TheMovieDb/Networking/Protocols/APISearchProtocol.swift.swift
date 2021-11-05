//
//  APISearchProtocol.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

typealias searchCompletion = (Result<Search, Error>) -> Void

protocol APISearchProtocol: AnyObject {
    func getByKeyword(with parameters: APIParameters, completion: @escaping(searchCompletion))
}

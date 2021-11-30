//
//  NetworkDispatcher.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case serverError
    case noData
    case decodingFailed
}

protocol NetworkDispatcher {
    func dispatch<RequestType: Request>(
        request: RequestType,
        completion: @escaping (Result<Data, Error>) -> Void
    )
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func dispatch<RequestType: Request>(
        request: RequestType,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let urlRequest = request.asURLRequest() else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        urlSession.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(.failure(NetworkError.serverError))
                return
            }
            
            guard let _data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(_data))
        }.resume()
    }
}

protocol APIClient {
    var dispatcher: NetworkDispatcher { get }
    
    func execute<RequestType: Request>(
        _ request: RequestType,
        completion: @escaping (Result<RequestType.ResponseType, Error>) -> Void
    )
}

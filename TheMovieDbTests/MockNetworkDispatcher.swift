//
//  MockNetworkDispatcher.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 28/11/21.
//

import Foundation
@testable import TheMovieDb

class MockNetworkDispatcher: NetworkDispatcher {
    
    var data: Data?
    
    var error: Error?
    
    func dispatch<RequestType>(request: RequestType, completion: @escaping (Result<Data, Error>) -> Void) where RequestType: Request {
        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
}

struct SimpleRequest: Request {
    var queryParams: [String: String]?
    
    var path = ""
    
    typealias ResponseType = SimpleResponse
}

struct SimpleResponse: Decodable {
    let testInt: Int
}

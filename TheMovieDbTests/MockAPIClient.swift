//
//  MockAPIClient.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 22/11/21.
//

import Foundation

class MockAPIClient: APIClient {
    var session: URLSession
    
    static let shared = MockAPIClient()
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func fetch<T>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        
    }
    
}

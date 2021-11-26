//
//  MockAPIClient.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 22/11/21.
//

import Foundation
import os
@testable import TheMovieDb

class MockAPIClient: APIClient {
    private let logger = Logger(subsystem: Constants.subsystemName, category: "MockAPIClient")
    var error: APIError?
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        // If error is setted, return error
        if let error = error {
            completion(.failure(error))
            return
        }
        
        var fileName = ""
        
        guard let urlString = request.url?.absoluteString else {
            completion(.failure(.invalidData))
            return
        }
        if urlString.contains("trending") {
            fileName = "Trending_example"
        } else if urlString.contains("configuration") {
            fileName = "Configuration_example"
        } else {
            completion(.failure(.invalidData))
            return
        }
        
        do {
            let data: T = try FileParser.createMockResponse(filename: fileName)
            completion(.success(data))
            return
        } catch {
            logger.error("\(error.localizedDescription)")
        }
        completion(.failure(.jsonConversionFailure))
    }
}

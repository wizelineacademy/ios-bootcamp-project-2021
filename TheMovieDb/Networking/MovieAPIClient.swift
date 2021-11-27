//
//  MovieAPIClient.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 22/11/21.
//

import Foundation

class MovieAPIClient: APIClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}

extension MovieAPIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(nil, .responseUnsuccessful)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: data)
                completion(genericModel, nil)
            } catch {
                completion(nil, .jsonConversionFailure)
            }
        }
        return task
    }

    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { json, error in
            guard let json = json else {
                if let error = error {
                    completion(Result.failure(error))
                } else {
                    completion(Result.failure(.invalidData))
                }
                return
            }
            if let value = decode(json) {
                completion(.success(value))
            } else {
                completion(.failure(.jsonParsingFailure))
            }
        }
        task.resume()
    }
}

//
//  APIClient.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    private func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
       
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let jsonData = JSONDecoder()
                        jsonData.keyDecodingStrategy = .convertFromSnakeCase
                        let genericModel = try jsonData.decode(decodingType, from: data)
                         completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
            let task = decodingTask(with: request, decodingType: T.self) { (json , error) in
                
                //MARK: change to main queue
                DispatchQueue.main.async {
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
            }
            task.resume()
        }
    
}

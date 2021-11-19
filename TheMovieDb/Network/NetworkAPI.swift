//
//  NetworkAPI.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

protocol ExecutorRequest {
    func execute<D: Decodable>(request: Request?,
                               onSuccess: @escaping (D?) -> Void,
                               onError: @escaping (Error?) -> Void)
}

final class MockNetworkAPI: ExecutorRequest {
    
    func execute<D>(request: Request?,
                    onSuccess: @escaping (D?) -> Void,
                    onError: @escaping (Error?) -> Void) where D : Decodable {
        guard let rawData = request?.jsonMock,
              let data = rawData.data(using: .utf8) else {
                  DispatchQueue.main.async {
                      onError(NetworkError.noResponse)
                  }
                  return
        }
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(D.self, from: data)
            DispatchQueue.main.async {
                onSuccess(object)
            }
        } catch let error {
            DispatchQueue.main.async {
                onError(error)
            }
        }
    }
}

final class NetworkAPI: ExecutorRequest {
    
    func execute<D: Decodable>(request: Request?,
                               onSuccess: @escaping (D?) -> Void,
                               onError: @escaping (Error?) -> Void) {
        guard let requestURL = request?.urlEndpoint else {
            DispatchQueue.main.async {
                onError(NetworkError.invalidData)
            }
            return
        }
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200 ..< 300 ~= response.statusCode,
                  error == nil else {
                      DispatchQueue.main.async {
                          onError(NetworkError.requestFailed)
                      }
                      return
                  }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = request?.decodingKey ?? .useDefaultKeys
                let object = try decoder.decode(D.self, from: data)
                DispatchQueue.main.async {
                    onSuccess(object)
                }
                return
            } catch {
                DispatchQueue.main.async {
                    onError(NetworkError.jsonParsingFailed)
                }
                return
            }
        }
        task.resume()
    }
}

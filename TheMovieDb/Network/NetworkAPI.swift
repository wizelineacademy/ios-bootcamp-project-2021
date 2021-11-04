//
//  NetworkAPI.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

protocol ExecutorRequest {
    associatedtype Response: Codable
    func execute(onSuccess: @escaping (Response?) -> Void,
                 onError: @escaping (Error?) -> Void)
}

final class Network<T: Codable>: ExecutorRequest {
    typealias Response = T
    private var request: Request?
    
    init(request: Request?) {
        self.request = request
    }
    
    func execute(onSuccess: @escaping (T?) -> Void,
                 onError: @escaping (Error?) -> Void) {
        guard let requestURL = request?.urlEndpoint else {
            onError(NetworkError.invalidData)
            return
        }
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200 ..< 300 ~= response.statusCode,
                  error == nil else {
                      onError(NetworkError.requestFailed)
                      return
                  }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = self.request?.decodingKey ?? .useDefaultKeys
                let object = try decoder.decode(T.self, from: data)
                onSuccess(object)
                return
            } catch {
                onError(NetworkError.jsonParsingFailed)
                return
            }
        }
        task.resume()
    }
}

final class NetworkAPI {
    
    static var shared: NetworkAPI = {
        return NetworkAPI()
    }()
    
    private init() {}
    
    func execute<D: Decodable>(request: Request?,
                               onSuccess: @escaping (D?) -> Void,
                               onError: @escaping (Error?) -> Void) {
        guard let requestURL = request?.urlEndpoint else {
            onError(NetworkError.invalidData)
            return
        }
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200 ..< 300 ~= response.statusCode,
                  error == nil else {
                      onError(NetworkError.requestFailed)
                      return
                  }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = request?.decodingKey ?? .useDefaultKeys
                let object = try decoder.decode(D.self, from: data)
                onSuccess(object)
                return
            } catch {
                onError(NetworkError.jsonParsingFailed)
                return
            }
        }
        task.resume()
    }
}

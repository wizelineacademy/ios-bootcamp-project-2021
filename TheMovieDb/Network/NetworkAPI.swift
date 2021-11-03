//
//  NetworkAPI.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation

final class NetworkAPI {
    
    static var shared: NetworkAPI = {
        return NetworkAPI()
    }()
    
    private init() {}
    
    func execute<D: Decodable>(request: Request?,
                               onSuccess: @escaping (D?) -> Void,
                               onError: @escaping (Error?) -> Void) {
        guard let requestURL = request?.urlEndpoint else {
            return
        }
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  200 ..< 300 ~= response.statusCode,
                  error == nil else {
                      onError(error)
                      return
                  }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = request?.decodingKey ?? .useDefaultKeys
                let object = try decoder.decode(D.self, from: data)
                onSuccess(object)
            } catch let error {
                onError(error)
            }
        }
        task.resume()
    }
}

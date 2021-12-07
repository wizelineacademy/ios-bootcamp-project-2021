//
//  NetworkAPI.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import Foundation
import Combine

protocol ExecutorRequest {
    func execute<D: Decodable>(request: Request?,
                               onSuccess: @escaping (D?) -> Void,
                               onError: @escaping (Error?) -> Void)
    func execute<D: Decodable>(request: Request?) -> AnyPublisher<D?, NetworkError>
}

final class MockNetworkAPI: ExecutorRequest {
    
    private let isErrorTesting: Bool
    
    init(isErrorTesting: Bool = false) {
        self.isErrorTesting = isErrorTesting
    }
    
    func execute<D>(request: Request?,
                    onSuccess: @escaping (D?) -> Void,
                    onError: @escaping (Error?) -> Void) where D : Decodable {
        
        let jsonMockString: String? = isErrorTesting ? "error" : request?.jsonMock

        guard let rawData = jsonMockString,
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
    
    func execute<D>(request: Request?) -> AnyPublisher<D?, NetworkError> where D : Decodable {
        let jsonMockString: String? = isErrorTesting ? "error" : request?.jsonMock
        guard let path = Bundle.main.path(forResource: jsonMockString, ofType: "json"),
              let decodingKey = request?.decodingKey else {
            return Fail(outputType: D?.self, failure: NetworkError.requestFailed)
                .eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = decodingKey
            let object = try decoder.decode(D?.self, from: data)
            return Just<D?>(object)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(outputType: D?.self, failure: NetworkError.jsonConversionFailed)
                .eraseToAnyPublisher()
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
    
    func execute<D>(request: Request?) -> AnyPublisher<D?, NetworkError> where D : Decodable {
        guard let request = request else {
            return Fail(outputType: D?.self, failure: NetworkError.requestFailed)
                .eraseToAnyPublisher()
        }
        guard let endpoint = request.urlEndpoint else {
            return Fail(outputType: D?.self, failure: NetworkError.invalidData)
                .eraseToAnyPublisher()
        }
        let decoderKey = request.decodingKey
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = decoderKey
        return URLSession.shared.dataTaskPublisher(for: endpoint)
            .map { $0.data }
            .decode(type: D?.self, decoder: jsonDecoder)
            .mapError({ error in
                switch error {
                case is Swift.DecodingError:
                    return NetworkError.jsonParsingFailed
                default:
                    return NetworkError.noResponse
                }
            })
            .eraseToAnyPublisher()
    }
}

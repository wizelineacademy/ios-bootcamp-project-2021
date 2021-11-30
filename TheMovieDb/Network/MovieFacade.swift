//
//  Facade.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation
import os.log
import Combine

struct MovieFacade: MovieService {
    
    func get<T: Decodable>(type: T.Type, search: String?, endpoint: MovieListEndpoint) -> AnyPublisher<T, MovieError> {
        
        guard let baseURL = URL(string:"https://api.themoviedb.org/3/") else {
            os_log("Network request error!", log: OSLog.networkRequest, type: .error)
            return Fail(error: MovieError.invalidUrl).eraseToAnyPublisher()
        }

        var components = URLComponents()
        components.path = endpoint.path
        components.queryItems = [
            .init(name: "api_key", value: RequestParams.apiKey),
            .init(name: "language", value: RequestParams.language)
        ]
        
        if let search = search {
            components.queryItems?.append(.init(name: "query", value: search))
        }
        
        guard let url = components.url(relativeTo: baseURL) else {
            os_log("Network request error!", log: OSLog.networkRequest, type: .error)
            return Fail(error: MovieError.invalidUrl).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError({ error -> MovieError in
                return MovieError.unknownError(error: error)
            })
            .eraseToAnyPublisher()
        }
}

//
//  Facade.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

struct MovieFacade: MovieService {
    
    static let baseURL = URL(string:"https://api.themoviedb.org/3/")!
    
    static func get<T: Decodable>(search: String? = nil, endpoint: MovieListEndpoint, returnResponse: @escaping (Result<T, MovieError>) -> Void) {

        var components = URLComponents()
        components.path = endpoint.path
        components.queryItems = [
            .init(name: "api_key", value: Constants.apiKey),
            .init(name: "language", value: Constants.language)
        ]
        
        if let search = search {
            components.queryItems?.append(.init(name: "query", value: search))
        }
        
        guard let url = components.url(relativeTo: baseURL) else {
            returnResponse(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let taskRequest = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                returnResponse(.failure(.unknownError(error: error)))
                print("Error took place \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                do {
                    let moviesDecoded = try jsonDecoder.decode(T.self, from: data)
                    returnResponse(.success(moviesDecoded))
                } catch {
                    returnResponse(.failure(.wrongResponse))
                }
            }
        }
        
        taskRequest.resume()
        
        }
}

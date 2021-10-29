//
//  Facade.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

struct MovieFacade: MovieService, QueryParams {
    
    static let baseURL = URL(string:"https://api.themoviedb.org/3/")!
    static var apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static var language = "en-US"
    
    static func getMovies(endpoint: MovieListEndpoint, returnMovies: @escaping (Result<MovieResponse, MovieError>) -> Void) {

        var components = URLComponents()
        components.path = endpoint.path
        components.queryItems = [
            .init(name: "api_key", value: apiKey),
            .init(name: "language", value: language)
        ]
        
        guard let url = components.url(relativeTo: baseURL) else {
            returnMovies(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let taskRequest = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                returnMovies(.failure(.unknownError(error: error)))
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
                    let moviesDecoded = try jsonDecoder.decode(MovieResponse.self, from: data)
                    print(moviesDecoded.page ?? "Not Found")
                    returnMovies(.success(moviesDecoded))
                } catch {
                    returnMovies(.failure(.wrongResponse))
                }
            }
        }
        
        taskRequest.resume()
        
        }
}

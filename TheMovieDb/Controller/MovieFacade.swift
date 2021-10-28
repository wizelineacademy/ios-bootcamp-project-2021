//
//  Facade.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

enum MovieListEndpoint {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    fileprivate var path: String {
        switch self {
        case .trending: return "trending/movie/week"
        case .nowPlaying: return "movie/now_playing"
        case .popular: return "movie/popular"
        case .topRated: return "movie/top_rated"
        case .upcoming: return "movie/upcoming"
        }
    }
}
enum HTTPMethod: String {
    case get, post, put, patch, delete, options, head
}

enum MovieError: Error {
    case invalidUrl
    case wrongResponse
    case unknownError(error: Error)
}

protocol MovieService {
    static func getMovies(endpoint: MovieListEndpoint, returnMovies: @escaping (Result<MovieResponse, MovieError>) -> Void)
}

struct MovieFacade: MovieService {
    
    static let baseURL = URL(string:"https://api.themoviedb.org/3/")!
    static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    static func getMovies(endpoint: MovieListEndpoint, returnMovies: @escaping (Result<MovieResponse, MovieError>) -> Void) {

        var components = URLComponents()
        components.path = endpoint.path
        components.queryItems = [
            .init(name: "api_key", value: apiKey)
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

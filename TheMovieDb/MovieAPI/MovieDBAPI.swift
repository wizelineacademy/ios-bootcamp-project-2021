//
//  TrendingRequest.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

struct MovieDBAPI: APIClient {
    
    private struct APIConstants {
        static let baseUrl = "https://api.themoviedb.org/"
        static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
    enum MoviesEndpoints: String {
        case trending = "3/trending/movie/day"
        case nowPlaying = "3/movie/now_playing"
        case popular = "3/movie/popular"
        case topRated = "3/movie/top_rated"
        case upcoming = "3/movie/upcoming"
    }
    
    var dispatcher: NetworkDispatcher
    
    init(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance) {
        self.dispatcher = dispatcher
    }
        
    func execute<RequestType: Request>(
        _ request: RequestType,
        completion: @escaping (Result<RequestType.ResponseType, Error>) -> Void
    ) {
        dispatcher.dispatch(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try jsonDecoder.decode(RequestType.ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    struct GetMovies: Request {
        var path: String
        var queryParams: [String: String]? = [
            "api_key": APIConstants.apiKey
        ]
        typealias ResponseType = MovieListResponse
        
        init(on endpoint: MoviesEndpoints, extraQueryParams: [String: String]? = nil) {
            self.path = APIConstants.baseUrl + endpoint.rawValue
            guard let newQueries = extraQueryParams else {
                return
            }
            queryParams?.merge(newQueries, uniquingKeysWith: { current, _ in current })
        }
    }
    
}

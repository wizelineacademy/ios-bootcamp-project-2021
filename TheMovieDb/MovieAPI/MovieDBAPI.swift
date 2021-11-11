//
//  TrendingRequest.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

private extension FeedTypes {
    var endpoint: MovieDBAPI.MoviesEndpoints {
        switch self {
        case .trending: return .trending
        case .nowPlaying: return .nowPlaying
        case .popular: return .popular
        case .topRated: return .topRated
        case .upcoming: return .upcoming
        case .search: return .search
        case .keyword: return .keyword
        }
    }
}

private extension RelatedMovieTypes {
    var endpoint: MovieDBAPI.MoviesEndpoints {
        switch self {
        case .recommendation: return .recommendations
        case .similar: return .similarMovies
        }
    }
}

protocol MovieFeedRepository {
    func getMovieFeed(on feed: FeedTypes, page: Int, query: String?, completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void)
}

protocol RelatedMoviesRepository {
    func getRelatedMovies(for movie: Movie, on related: RelatedMovieTypes, completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void)
}

protocol MovieCastRepository {
    func getMovieCast(for movie: Movie, completion: @escaping (Result<MovieCastResponse, Error>) -> Void)
}

protocol MovieReviewsRepository {
    func getMoviewReviews(for movie: Movie, page: Int, completion: @escaping (Result<MovieDBAPIListResponse<Review>, Error>) -> Void)
}

struct MovieDBAPI: APIClient {
    
    struct APIConstants {
        static let baseUrl = "https://api.themoviedb.org/"
        static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
        static let imageUrl = "https://image.tmdb.org/t/p/w500/"
    }
    
    enum MoviesEndpoints: String {
        case trending = "3/trending/movie/day"
        case nowPlaying = "3/movie/now_playing"
        case popular = "3/movie/popular"
        case topRated = "3/movie/top_rated"
        case upcoming = "3/movie/upcoming"
        case search = "3/search/movie"
        case keyword = "3/search/keyword"
        case recommendations = "3/movie/{movie_id}/recommendations"
        case similarMovies = "3/movie/{movie_id}/similar"
        case cast = "3/movie/{movie_id}/credits"
        case reviews = "3/movie/{movie_id}/reviews"
    }
    
    let dispatcher: NetworkDispatcher
    
    init(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher()) {
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
    
    struct GetList<Model: Decodable>: Request {
        var path: String
        var queryParams: [String: String]? = [
            "api_key": APIConstants.apiKey
        ]
        typealias ResponseType = MovieDBAPIListResponse<Model>
        
        enum QueryParamsKeys: String {
            case page
            case query
        }
        
        init(on path: String, queries: [QueryParamsKeys: String]? = nil) {
            self.path = APIConstants.baseUrl + path
            guard let queries = queries else {
                return
            }
            queries.forEach { key, value in
                addNewQueryParam(value, forKey: key.rawValue)
            }
        }
    }
    
    struct GetCast: Request {
        var path: String
        var queryParams: [String: String]? = [
            "api_key": APIConstants.apiKey
        ]
        typealias ResponseType = MovieCastResponse
        
        init(on path: String) {
            self.path = APIConstants.baseUrl + path
        }
    }
    
}

extension MovieDBAPI: MovieFeedRepository {
    func getMovieFeed(
        on feed: FeedTypes,
        page: Int,
        query: String? = nil,
        completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void
    ) {
        var request = GetList<Movie>(
            on: feed.endpoint.rawValue,
            queries: [.page: String(page)]
        )
        if let query = query {
            request.addNewQueryParam(query, forKey: GetList<Movie>.QueryParamsKeys.query.rawValue)
        }
        execute(request, completion: completion)
    }
}

extension MovieDBAPI: RelatedMoviesRepository {
    func getRelatedMovies(
        for movie: Movie,
        on related: RelatedMovieTypes,
        completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void
    ) {
        let path = related.endpoint
            .rawValue
            .replacingOccurrences(
                of: "{movie_id}",
                with: String(movie.id)
            )
        execute(GetList(on: path), completion: completion)
    }
}

extension MovieDBAPI: MovieCastRepository {
    func getMovieCast(
        for movie: Movie,
        completion: @escaping (Result<MovieCastResponse, Error>) -> Void
    ) {
        let path = MoviesEndpoints.cast
            .rawValue
            .replacingOccurrences(
                of: "{movie_id}",
                with: String(movie.id)
            )
        execute(GetCast(on: path), completion: completion)
    }
}

extension MovieDBAPI: MovieReviewsRepository {
    func getMoviewReviews(
        for movie: Movie,
        page: Int,
        completion: @escaping (Result<MovieDBAPIListResponse<Review>, Error>) -> Void
    ) {
        let path = MoviesEndpoints.reviews
            .rawValue
            .replacingOccurrences(
                of: "{movie_id}",
                with: String(movie.id)
            )
        execute(GetList(on: path), completion: completion)
    }
}

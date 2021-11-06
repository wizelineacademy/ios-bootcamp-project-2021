//
//  API.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 27/10/21.
//

import Foundation

protocol LSRequest {
  var method: HTTPMethod { get }
  var parameters: [String: Any]? { get }
  var url: String { get }
  var headers: [String: String]? { get }
  func createURL() -> URLRequest?
  func resume<T: Codable>(completion: @escaping (Result<T, Error>) -> Void)
}

extension API: LSRequest {
  var method: HTTPMethod {
    switch self {
    case .getNowPlayingMovies, .getPopularMovies, .getTrendingMovies, .getUpcomingMovies, .getTopRatedMovies, .getRecommendedMovies, .getSimilarMovies, .getReviews, .searchMovies:
      return .get
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .getTrendingMovies, .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies, .getNowPlayingMovies:
      return nil
    case .getRecommendedMovies, .getSimilarMovies, .getReviews:
      return nil
    case .searchMovies
    
    }
  }
  
  var url: String {
    switch self {
    case .getTrendingMovies:
      return "\(baseURL)/trending/movie/day?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&region=US&page=1"
    case .getNowPlayingMovies:
      return "\(baseURL)/movie/now_playing?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&region=US&page=1"
    case .getPopularMovies:
      return "\(baseURL)/movie/popular?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&region=US&page=1"
    case .getTopRatedMovies:
      return "\(baseURL)/movie/top_rated?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&page=1&region=US"
    case .getUpcomingMovies:
      return "\(baseURL)/movie/upcoming?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&region=US&page=1"
    case .getRecommendedMovies(let id):
      return "\(baseURL)/movie/\(id)/recommendations?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en"
    case .getSimilarMovies(let id):
      return "\(baseURL)/movie/\(id)/similar?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en"
    case .getReviews(let id):
      return "\(baseURL)/movie/\(id)/reviews?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&language=en-US"
    case .searchMovies(let search):
      return "\(baseURL)/search/movie?api_key=\(Bundle.main.infoDictionary?["APIKEY"] ?? "")&language=en&page=2&query=\(search)"
    }
  }
  
  var headers: [String: String]? {
    return nil
  }
  
  func createURL() -> URLRequest? {
    guard let url = URL(string: self.url) else {
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = self.method.rawValue
    request.allHTTPHeaderFields = self.headers
    if let parameters = self.parameters {
      do {
        let data = try JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        request.httpBody = data
      } catch {
        debugPrint(error)
        return nil
      }
    }
    return request
  }
  
  func resume<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
    guard let request = createURL() else {
      return
    }
    URLSession.shared.dataTask(with: request) { (data, _, error) in
      guard let data = data else {
        completion(.failure(NetworkError.networkError(error: error)))
        return
      }
      
      let decoder = JSONDecoder()
      do {
        let dataResponse = try decoder.decode(T.self, from: data)
        debugPrint(dataResponse)
        DispatchQueue.main.async {
          completion(.success(dataResponse))
        }
        
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }.resume()
  }
  
}

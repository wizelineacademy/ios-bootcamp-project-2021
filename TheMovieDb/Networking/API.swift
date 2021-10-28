//
//  API.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 27/10/21.
//

import Foundation

let baseURL = "https://api.themoviedb.org/3"
private let apiKey = "dc8558900a17ca7149d85463428100bc"

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol LSRequest {
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var url: String { get }
    var headers: [String: String]? { get }
    func resume<T: Codable>(completion: @escaping (Result<T, Error>) -> Void)
}
enum APIInformation {
  var baseURL: String {
    return "https://api.themoviedb.org/3"
  }
}

enum APIs {
  case getTrendingMovies
  case getNowPlayingMovies
  case getPopularMovies
  case getTopRatedMovies
  case getUpcomingMovies
}

extension APIs: LSRequest {
  var method: HTTPMethod {
    switch self {
    case .getNowPlayingMovies, .getPopularMovies, .getTrendingMovies, .getUpcomingMovies, .getTopRatedMovies:
      return .get
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    case .getTrendingMovies, .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies, .getNowPlayingMovies:
      return nil
    }
  }
  
  var url: String {
    switch self {
    case .getTrendingMovies:
      return "\(baseURL)/trending/movie/day?api_key=\(apiKey)&language=en&region=US&page=1"
    case .getNowPlayingMovies:
      return "\(baseURL)/movie/now_playing?api_key=\(apiKey)&language=en&region=US&page=1"
    case .getPopularMovies:
      return "\(baseURL)/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    case .getTopRatedMovies:
      return "\(baseURL)/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US"
    case .getUpcomingMovies:
      return "\(baseURL)/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    }
  }
  
  var headers: [String: String]? {
    return nil
  }
  
  func resume<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable, T: Encodable {
    guard let url = URL(string: self.url) else {
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = self.method.rawValue
    
    request.allHTTPHeaderFields = self.headers
    
    if let parametros = self.parameters {
        do {
            let data = try JSONSerialization.data(withJSONObject: parametros, options: .fragmentsAllowed)
            request.httpBody = data
        } catch {
            debugPrint(error)
            completion(.failure(error))
        }
    }
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
      guard let data = data else {
        completion(.failure(NetworkError.networkError(error: error)))
        return
      }
      
      #if DEBUG
      debugPrint(self.url)
      debugPrint(self.parameters ?? [:])
      if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
        debugPrint(json)
      }
      #endif
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

//
//  APIManager.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation
import UIKit

struct RequestFields {
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
    
}
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum Topic: String, CaseIterable {
    case trending = "/trending/movie/day"
    case popular = "/movie/popular"
    case nowPlaying = "/movie/now_playing"
    case topRated = "/movie/top_rated"
    case upcoming = "/movie/upcoming"

}

struct HeadersForString {
    static let apiKey = "?api_key="
    static let language = "&language=en"
    static let region = "&region=US"
    static let page = "&page=1"
    static let languageUS = "&language=en-US"
    static let query = "&query="
    static let includeAdultFalse = "&include_adult=false"
}

enum Endpoints: String {
    case similar = "/movie/"
    case search = "/search/movie"
    case reviews = "/reviews"
    static func similar(movieId: String) -> String {
        return BaseURL.baseUrl + Endpoints.similar.rawValue + movieId + "/similar?api_key=" + ApiKey.apiKey
    }
    
    static func detailOfMovie(id: String) -> String {
        return BaseURL.baseUrl + "/movie/" + id + "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en-US"
    }
    
    static func search(text: String) -> String {
        return BaseURL.baseUrl + Endpoints.search.rawValue + HeadersForString.apiKey + ApiKey.apiKey + HeadersForString.languageUS + HeadersForString.query + text + HeadersForString.page + HeadersForString.includeAdultFalse
    }
    
//https://api.themoviedb.org/3/movie/603/reviews?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&language=en-US
    static func reviewsOfMovie(id: String) -> String {
       return BaseURL.baseUrl + "/movie/" + id + Endpoints.reviews.rawValue +  HeadersForString.apiKey + ApiKey.apiKey + HeadersForString.languageUS
    }
}

extension Topic {

    func getPath() -> String {
        return BaseURL.baseUrl + self.rawValue + HeadersForString.apiKey + ApiKey.apiKey + HeadersForString.language + HeadersForString.region + HeadersForString.page
    }
}

struct BaseURL {
    static var baseUrl = "https://api.themoviedb.org/3"
    static let baseUrlForImage = "https://image.tmdb.org/t/p/w500"
}

struct ApiKey {
    static let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}

protocol APIRequest {
   // var topic: Topic { get set}
    var method: HTTPMethod { get set }
    var path: String { get set }
    // add all the other stuff header params and eveyrthing i need for a request
}

extension APIRequest {
    var method: HTTPMethod {  return .get }
}

struct Request: APIRequest {
    var path: String
   // var topic: Topic
    var method: HTTPMethod
    var group: DispatchGroup?
}

class DecoderJson {
    
    static func decode<T: Decodable>(value: T.Type, data: Data?) -> T? {
        
        do {
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decoded = try decoder.decode(T.self, from: data)
                return decoded
            }
        } catch let error {
            print(error)
            return nil
        }
        return nil
    }
}

enum NetworkError: Int, Error {
    case failure = 404
    case succes = 200
    case unknown = 0
}

class MovieDbAPI {
    
    static func request<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void ) {
        let group = request.group
        group?.enter()
        guard let url = URL(string: request.path) else {
            completion(.failure(NetworkError.failure))
            return
        }
        var request = URLRequest(url: url)
        
        request.setValue(RequestFields.applicationJson, forHTTPHeaderField: RequestFields.contentType)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
           
            if let decoded = DecoderJson.decode(value: T.self, data: data) {
                completion(.success(decoded))
            } else {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                let networkError: Error = NetworkError(rawValue: httpResponse.statusCode) ?? error ?? NetworkError.unknown
                completion(.failure(networkError))
            }
            group?.leave()
        }.resume()
        
    }
}

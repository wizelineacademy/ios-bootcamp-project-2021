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
    case trending = "/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    case popular = "/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    case nowPlaying = "/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
    case topRated = "/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&page=1&region=US"
    case upcoming = "/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
}

enum Enpoints: String {
   // case similar = "/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en"
    case similar = "/movie/"

    static func similar(movieId: String) -> String {
        return BaseURL.baseUrl + Enpoints.similar.rawValue + movieId + "/similar?api_key=" + ApiKey.apiKey
    }
}

extension Topic {

    func getPath() -> String {
        return BaseURL.baseUrl + self.rawValue
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

class MovieDbAPI {
    
    static func request<T: Decodable>(value: T.Type, request: Request, completion: @escaping (_ results: T?) -> Void ) {
        let group = request.group
        group?.enter()
        let url = URL(string: request.path)!
        var request = URLRequest(url: url)
        
        request.setValue(RequestFields.applicationJson, forHTTPHeaderField: RequestFields.contentType)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let decoded = DecoderJson.decode(value: T.self, data: data) {
                completion(decoded)
            } else {
                completion(nil)
            }
            group?.leave()
        }.resume()
        
    }
}

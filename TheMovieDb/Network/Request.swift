//
//  Request.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 01/11/21.
//

import Foundation

class NetworkManager {
    let urlSession: URLSession
    
    // Setting fixed values of url
    private let scheme = "https"
    private let baseURL = "api.themoviedb.org"
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let language = "en-US"
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request(path: String, urlQueryitems: [URLQueryItem]?) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language)
        ]
        
        if let urlQueryitems = urlQueryitems {
            urlComponents.queryItems?.append(contentsOf: urlQueryitems)
        }
        
        guard let url = urlComponents.url else { fatalError("Error: invalid request") }
        let request = URLRequest(url: url)
        return request
    }
    
    func get<Response: Decodable>(path: String, urlQueryitems: [URLQueryItem]?, completion: @escaping (Response) -> Void ) {
        let urlRequest = request(path: path, urlQueryitems: urlQueryitems)
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
            }

            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode(Response.self, from: data)
                
                completion(posts)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}

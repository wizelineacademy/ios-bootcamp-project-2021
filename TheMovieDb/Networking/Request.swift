//
//  Request.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 28/10/21.
//

import Foundation

final class NetworkManager {
    
    let urlSession: URLSession
    private let baseURL = "https://api.themoviedb.org"
    private let apiKey = "api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func request(path:String) -> URLRequest {
        
        let queryItemApiKey = URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a")
        let queryItemLanguage = URLQueryItem(name: "language", value: "en")
        let queryItemRegion = URLQueryItem(name: "region", value: "US")
        let queryItemPage = URLQueryItem(name: "page", value: "1")
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = path
        components.queryItems = [
            queryItemApiKey,
            queryItemLanguage,
            queryItemRegion,
            queryItemPage
        ]
        
        guard let url = components.url else { fatalError("Error: invalid url") }
        let request = URLRequest (url: url)
        return request
    }
    
    
    
    func get<Response: Decodable>(path: String, completion: @escaping (Response) -> Void ) {
        let urlRequest = request(path: path)
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                fatalError("Error: invalid HTTP response code")
            }
            
            guard let data = data else {
                fatalError("Error: missing response data")
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode(Response.self, from: data)
                completion(posts)
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}




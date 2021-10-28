//
//  NetworkDispatcher.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 27/10/21.
//

import Foundation

enum ConnError: Error {
    case invalidURL
    case noData
}

protocol NetworkDispatcher {
    func dispatch(
        request: RequestData,
        onSuccess: @escaping (Data) -> Void,
        onError: @escaping (Error) -> Void
    )
}

struct URLSessionNetworkDispatcher: NetworkDispatcher {
    
    static let instance = URLSessionNetworkDispatcher()
    
    private init() {}
    
    func dispatch(
        request: RequestData,
        onSuccess: @escaping (Data) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        guard var urlComponents = URLComponents(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        urlComponents.queryItems = request.queryParams?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponents.url else {
            onError(ConnError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
        }.resume()
    }
}

//
//  getMovieList.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 07/11/21.
//

import Foundation

struct GetMovieList {
    
    func getMoviesList(option: RequestPaths, completion: @escaping (MovieList) -> Void) {
        let service = NetworkManager(urlSession: URLSession.shared)
        service.get(path: option.path, urlQueryitems: nil) { response in
            completion(response)
        }
    }
    
}

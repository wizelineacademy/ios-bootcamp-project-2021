//
//  SearchRepository.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 04/11/21.
//

import Foundation

struct SearchByIdRepo {
    
    func searchMovieById(id: Int, completion: @escaping (Movie) -> Void) {
        let service = NetworkManager(urlSession: URLSession.shared)
        let requestPath = RequestPaths.searchById(movieId: id)
        service.get(path: requestPath.path, urlQueryitems: nil) { response in
            completion(response)
        }
    }
    
}

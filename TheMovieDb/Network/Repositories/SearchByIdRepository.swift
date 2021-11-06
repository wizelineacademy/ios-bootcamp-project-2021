//
//  SearchRepository.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 04/11/21.
//

import Foundation

class SearchByIdRepo {
    let pathComposer = PathComposer()
    func searchMovieById(id: Int, completion: @escaping (Movie) -> Void) {
        let service = NetworkManager(urlSession: URLSession.shared)
        let path = pathComposer.composePath(for: .searchById(movieId: id))
        service.get(path: path, urlQueryitems: nil) { response in
            completion(response)
        }
    }
}

//
//  MakeRequest.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation
class MakeRequest {
    weak var delegate: DataLoaded?
    var movies: [Movie] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    let service = NetworkManager(urlSession: URLSession.shared)
    
    
    func getMoviesRequest(basePath: String) {
        service.get(path: basePath) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    
    func handleResponse(_ response: MovieList) {
        DispatchQueue.main.async {
            self.movies = response.results
        }
    }
}

protocol DataLoaded: AnyObject {
    func reloadData()
}

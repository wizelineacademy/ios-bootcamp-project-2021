//
//  MoviesRepositoryImpl.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

class MoviesRepositoryImpl {
    let service = NetworkManager(urlSession: URLSession.shared)
    var basePath = ""
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    func requestMovies() {
        service.get(path: basePath) { [weak self] response in
            _ = self?.handleResponse(response)
        }
    }
    
    private func handleResponse(_ response: MovieList) -> [Movie] {
        var movies: [Movie] = []
        DispatchQueue.main.async {
            movies = response.results
        }
        return movies
    }
}

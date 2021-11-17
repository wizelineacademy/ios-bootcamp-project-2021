//
//  GetLatestMoviesRepositoryImpl.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

class GetLatestMoviesRepositoryImpl: GetLatestMoviesRepository{
    func getLatestMovies() {
        service.get(path: basePath) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    var movies: [Movie] = []
    private let basePath: String = URLRequestType.popular.basePath
    let service = NetworkManager(urlSession: URLSession.shared)
    
    func handleResponse(_ response: MovieList) {
        DispatchQueue.main.async {
            self.movies = response.results
        }
    }
}

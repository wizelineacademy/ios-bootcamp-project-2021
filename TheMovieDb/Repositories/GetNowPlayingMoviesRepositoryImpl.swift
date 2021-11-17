//
//  GetNowPlayingMoviesRepositoryImpl.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

class GetNowPlayingMoviesRepositoryImpl: GetNowPlayingMoviesRepository {
    func getNowPlayingMoviesRepository() {
        service.get(path: basePath) { [weak self] response in
            self?.handleResponse(response)
        }
    }
    
    var movies: [Movie] = []
    let service = NetworkManager(urlSession: URLSession.shared)
    private let basePath: String = URLRequestType.popular.basePath

    
    func handleResponse(_ response: MovieList) {
        DispatchQueue.main.async {
            self.movies = response.results
        }
    }
}

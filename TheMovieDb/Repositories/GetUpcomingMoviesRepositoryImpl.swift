//
//  GetUpcomingMoviesRepositoryImplementation.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation
class GetUpcomingMoviesRepositoryImpl: GetUpcomingMoviesRepository {
    var movies: [Movie] = []
    private let basePath: String = URLRequestType.upcoming.basePath
    let service = NetworkManager(urlSession: URLSession.shared)
    
    func getUpcomingMovies() {
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

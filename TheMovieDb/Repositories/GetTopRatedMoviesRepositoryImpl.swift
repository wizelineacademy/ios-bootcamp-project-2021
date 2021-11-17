//
//  GetTopRatedMoviesRepositoryImpl.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

class GetTopRatedMoviesRepositoryImpl: GetListMoviesRepository {
    weak var delegate: DataLoadedFromRepository?
    var movies: [Movie] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    private let basePath: String = URLRequestType.popular.basePath
    let service = NetworkManager(urlSession: URLSession.shared)
    
    func getListMovies() {
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

protocol DataLoadedFromRepository: AnyObject {
    func reloadData()
}

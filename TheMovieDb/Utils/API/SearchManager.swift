//
//  SearchManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

import Foundation

class SearchManager: SearchingDataProtocol {
    weak var delegate: GetMoviesDelegate?
    func getMovie(with parameters: APIParameters) {
        var movies: [Movie] = []
        MovieAPI.shared.fetchData(endPoint: .search, with: parameters, completion: { (response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                movies = res.movies
            }
            self.delegate?.didGetMovies(movies: movies)
        })
    }
    
}

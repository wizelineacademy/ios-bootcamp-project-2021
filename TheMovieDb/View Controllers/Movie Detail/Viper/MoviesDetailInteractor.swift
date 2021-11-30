//
//  MoviesDetailInteractor.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import CloudKit

final class MoviesDetailInteractor: MoviesDetailInteractorInputProtocol {
    var apiDataManager: MoviesDetailAPIDataManagerProtocol?
    var presenter: MoviesDetailInteractorOutputProtocol?
    
    func fetchDetail(of movie: MovieProtocol) {
        
        let group = DispatchGroup()
        let request = Request(path: Endpoints.detailOfMovie(id: movie.id.description), method: .get, group: group)

        apiDataManager?.requestMovieDetail(value: MovieDetail.self, request: request) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                if let movie = movieDetail {
                    self?.presenter?.didFetchMovieDetail(movieDetail: movie)
                }
                
            case .failure(let error):
                self?.presenter?.didFailFetchMovieDetailWith(error: error)
            }
        }
      
    }
    
    func fetchSimilarMoviesFor(movie: MovieProtocol) {
        
        let group = DispatchGroup()
        let request = Request(path: Endpoints.similar(movieId: movie.id.description), method: .get)
    
        apiDataManager?.requestSimilarMovies(value: MovieList.self, request: request, completion: { [weak self] result in
            switch result {
            case .success(let result):
                group.notify(queue: .main) {
                    guard let similarMovies = result else { return }
                    self?.presenter?.didFetchSimilarMoviesFor(movies: similarMovies)
                }
                
            case .failure(let failure):
                self?.presenter?.didFailFetchSimilarMoviesWith(error: failure)
            }
        })
    }
    
}

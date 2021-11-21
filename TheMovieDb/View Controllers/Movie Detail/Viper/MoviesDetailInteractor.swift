//
//  MoviesDetailInteractor.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import CloudKit

final class MoviesDetailInteractor: MoviesDetailInteractorInputProtocol {
    var presenter: MoviesDetailInteractorOutputProtocol?
    
    func fetchDetail(of movie: MovieProtocol) {
        
        let group = DispatchGroup()
        let request = Request(path: Endpoints.detailOfMovie(id: movie.id.description), method: .get, group: group)
        print(request.path)
        MovieDbAPI.request(value: MovieDetail.self, request: request) { [weak self] result in
            switch result {
            case .success(let result):
                group.notify(queue: .main) {
                    guard let movieDetail = result else { return }
                    self?.presenter?.didFetchMovieDetail(movieDetail: movieDetail)
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchSimilarMoviesFor(movie: MovieProtocol) {
        
        let group = DispatchGroup()
        let request = Request(path: Endpoints.similar(movieId: movie.id.description), method: .get)
        MovieDbAPI.request(value: MovieList.self, request: request) { [weak self] result in
            
            switch result {
            case .success(let result):
                group.notify(queue: .main) {
                    guard let similarMovies = result else { return }
                    self?.presenter?.didFetchSimilarMoviesFor(movies: similarMovies)
                }
                
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}

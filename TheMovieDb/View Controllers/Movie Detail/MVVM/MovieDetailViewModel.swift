//
//  MovieDetailViewModel.swift
//  TheMovieDb
//
//  Created by Angel Coronado Quintero on 12/01/22.
//

import Foundation
import UIKit

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    func getScreenTitle() -> String {
        return movie.title
    }
    
    func showMovieReviews(view: UIViewController) {
        self.router?.pushReviewsViewControllerFrom(view: view, with: movie)
    }
    
    func fetchDetail() {
        self.fetchDetailWith(movie: movie)
    }
    
    func fetchSimiliar() {
        self.fetchSimiliarMoviesWith(movie: movie)
    }
    
    var router: MoviesDetailRouterProtocol?
    
    var didFailFetchingMovieDetail: ((Error) -> Void)?
    
    var didFetchSimilarMovies: ((MovieList) -> Void)?
    
    var didFailFetchingSimilarMovies: ((Error) -> Void)?
    
    var movieDetail: MovieDetailProtocol?
    var similarMovies: MovieList?
    var detailItems: [MovieDetailCellsLayout] = [.header, .similar]
   
    var didFetchMovieDetail: ((MovieDetailProtocol) -> Void)?
    var apiDataManager: MoviesDetailAPIDataManagerProtocol?
    var movie: MovieProtocol
    
    init(movie: MovieProtocol, apiManager: MoviesDetailAPIDataManagerProtocol, router: MoviesDetailRouterProtocol) {
        self.movie = movie
        self.apiDataManager = apiManager
        self.router = router
    }
    
    func fetchAllDetailData() {
        self.fetchDetailWith(movie: movie)
        self.fetchSimiliarMoviesWith(movie: movie)
    }
    
    func fetchDetailWith(movie: MovieProtocol) {
        let group = DispatchGroup()
        let request = Request(path: Endpoints.detailOfMovie(id: movie.id.description), method: .get, group: group)

        apiDataManager?.requestMovieDetail(value: MovieDetail.self, request: request) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                if let movie = movieDetail {
                    self?.movieDetail = movie
                    self?.didFetchMovieDetail?(movie)
                }
                
            case .failure(let error):
                self?.didFailFetchingMovieDetail?(error)
            }
        }
        
    }
    
    func fetchSimiliarMoviesWith(movie: MovieProtocol) {
        let group = DispatchGroup()
        let request = Request(path: Endpoints.similar(movieId: movie.id.description), method: .get)
    
        apiDataManager?.requestSimilarMovies(value: MovieList.self, request: request, completion: { [weak self] result in
            switch result {
            case .success(let result):
                group.notify(queue: .main) {
                    guard let similarMovies = result else { return }
                    self?.similarMovies = similarMovies
                    self?.didFetchSimilarMovies?(similarMovies)
                }
                
            case .failure(let failure):
                self?.didFailFetchingSimilarMovies?(failure)
            }
        })
    }
    
    func showMovieDetailWith(movie: MovieProtocol, from view: UIViewController) {
        router?.pushDetailViewControllerFrom(view: view, with: movie)
    }
   
}

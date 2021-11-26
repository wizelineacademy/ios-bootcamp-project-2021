//
//  DetailViewPresenter.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 22/11/21.
//

import Foundation
import OSLog

protocol DetailViewPresenter {
    func fetchAllMovieList()
    func setUpMovie()
}

final class DetailViewPresenterImp: DetailViewPresenter {
    
    private var dctMoviesBySection: [SectionMovieDetail: [AnyHashable]] = [:]
    private let clientMovie: MovieDBClient
    private let movieSelected: MovieViewModel
    weak var detailView: DetailView?
    let downloadGroup = DispatchGroup()
    init(client: MovieDBClient, movie: MovieViewModel) {
        self.clientMovie = client
        self.movieSelected = movie
    }
    
    func fetchAllMovieList() {
        self.dctMoviesBySection.updateValue([movieSelected], forKey: .header)
            self.detailView?.showLoading()
            for sectionMovie in SectionMovieDetail.allCases {
                
                switch sectionMovie {
                case .similar, .reccommendattions:
                    self.fetchMoviesSection(forSection: sectionMovie)
                case .comment:
                    self.fetchComments(forSection: sectionMovie)
                default:
                    break
                }
            }
    
            downloadGroup.notify(queue: DispatchQueue.main) {
                print("Success!!")
                self.detailView?.loadSectionMovies(listSection: self.dctMoviesBySection)
                self.detailView?.stopLoading()
            }
    }
    
    private func fetchMoviesSection(forSection sectionMovie: SectionMovieDetail) {
        downloadGroup.enter()
        self.clientMovie.getMoviesFrom(type: sectionMovie, page: 1, id: self.movieSelected.id, completion: { [weak self] result in
            switch result {
            case .success(let respMovie):
                guard let movieResult = respMovie,
                      let movieList = movieResult.results
                else { return }
                let viewModels = movieList.map {
                    MovieViewModel(movie: $0)
                }
                
                self?.dctMoviesBySection[sectionMovie] = viewModels
                
            case .failure(let error):
                os_log("Error: %@", log: .default, type: .error, String(describing: error))
            }
            self?.downloadGroup.leave()
        })
    }
    
    private func fetchComments(forSection sectionMovie: SectionMovieDetail) {
        downloadGroup.enter()
        self.clientMovie.getReviewsMovie(page: 1, movieId: self.movieSelected.id, completion: { [weak self] result in
            switch result {
            case .success(let respReview):
                guard let reviewResult = respReview,
                      let reviewList = reviewResult.results
                else { return }
                let viewModels = reviewList.map {
                    ReviewViewModel(review: $0)
                }
                self?.dctMoviesBySection[sectionMovie] = viewModels
                
            case .failure(let error):
                os_log("Error: %@", log: .default, type: .error, String(describing: error))
            }
            self?.downloadGroup.leave()
        })
    }
    
    func setUpMovie() {
        
        self.detailView?.configureMovie(movie: movieSelected)
    }
}

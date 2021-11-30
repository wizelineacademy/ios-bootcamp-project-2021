//
//  HomeViewPresenter.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 20/11/21.
//

import Foundation
import OSLog

final class HomePresenter {

    private let service: MovieFeedRepository
    
    weak var delegate: HomeViewPresenterDelegate?
    
    private var movies = [Movie]()
    
    private var isLoading = false {
        didSet {
            isLoading ? delegate?.didStartLoading() : delegate?.didFinishLoading()
        }
    }
    
    private var loadedPages: Int = .zero
    
    private var nextPage: Int {
        loadedPages + 1
    }
    
    var isSearching = false {
        didSet {
            currentFeed = isSearching ? .search : .trending
            isSearching ? delegate?.didStartSearching() : delegate?.didFinishSearching()
        }
    }
    
    var currentFeed: FeedTypes = .trending {
        didSet {
            resetFeed()
            if !isSearching {
                getMoviesIfNeeded(search: nil)
            }
        }
    }
    
    init(service: MovieFeedRepository = MovieDBAPI()) {
        self.service = service
    }
    
    func getMoviesIfNeeded(search: String? = nil) {
        guard !isLoading else {
            return
        }
        isLoading = true
        service.getMovieFeed(
            on: currentFeed,
            page: nextPage,
            query: search
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleFeedResponse(response)
            case .failure:
                os_log("Network request error", log: OSLog.networkRequest, type: .debug)
            }
            self?.isLoading = false
        }
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
    
    func getMovie(forPosition index: Int) -> Movie {
        movies[index]
    }
    
    func handleFeedResponse(_ response: MovieDBAPIListResponse<Movie>) {
        loadedPages = response.page
        movies.append(contentsOf: response.results)
        delegate?.didUpdateMovies(movies)
    }
    
    func resetFeed() {
        movies.removeAll()
        loadedPages = .zero
        self.delegate?.didUpdateMovies(movies)
    }
    
}

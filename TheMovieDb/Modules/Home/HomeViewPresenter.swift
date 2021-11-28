//
//  HomeViewPresenter.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 20/11/21.
//

import Foundation
import OSLog

final class HomeViewPresenter {

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
                self?.loadedPages = response.page
                self?.movies.append(contentsOf: response.results)
                guard let movies = self?.movies else {
                    return
                }
                self?.delegate?.didUpdateMovies(movies)
            case .failure:
                os_log("Network request error", log: OSLog.networkRequest, type: .debug)
            }
            self?.isLoading = false
        }
    }
    
    func resetFeed() {
        movies.removeAll()
        loadedPages = .zero
        self.delegate?.didUpdateMovies(movies)
    }
    
}

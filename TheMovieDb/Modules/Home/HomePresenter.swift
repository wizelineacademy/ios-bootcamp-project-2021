//
//  HomePresenter.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 20/11/21.
//

import Foundation
import OSLog
import UIKit

final class HomePresenter {

    private let service: MovieFeedRepository
    
    private let imageLoader: ImageProvider
    
    weak var delegate: HomePresenterDelegate?
    
    private let cache = Cache<String, UIImage>()
    
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
    
    init(service: MovieFeedRepository = MovieDBAPI(), imageLoader: ImageProvider = ImageLoader()) {
        self.service = service
        self.imageLoader = imageLoader
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
    
    func getMoviePoster(forPosition index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let posterpath = movies[index].posterPath,
              let posterURL = URL(string: MovieDBAPI.APIConstants.imageUrl + posterpath)
            else {
            completion(nil)
            return
        }
        imageLoader.getImage(withURL: posterURL, completion: completion)
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

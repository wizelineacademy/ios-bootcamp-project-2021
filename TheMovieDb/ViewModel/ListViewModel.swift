//
//  ListViewModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    func didBeginRefreshing()
    func didEndRefreshing()
    func nothingFound()
}

class ListViewModel: NSObject {
    private let movieModel: MovieAPIModel
    private var movieList: [MovieViewModel] = []
    var movieFeed: MovieFeed
    
    private weak var delegate: ListViewModelDelegate?
    
    init(movieModel: MovieAPIModel, movieFeed: MovieFeed, delegate: ListViewModelDelegate? = nil) {
        self.movieModel = movieModel
        self.movieFeed = movieFeed
        self.delegate = delegate
    }
    
    var numberOfCells: Int {
        movieList.count
    }
    
    func movie(at index: Int) -> MovieViewModel {
        movieList[index]
    }
    
    @objc func refresh() {
        delegate?.didBeginRefreshing()
        
        movieModel.getList(movieFeed: movieFeed) { [weak self] movies in
            self?.movieList = movies
            self?.didRefresh()
            if movies.isEmpty {
                self?.nothingFound()
            }
        }
    }
    
    func didRefresh() {
        self.delegate?.didEndRefreshing()
    }
    
    func nothingFound() {
        self.delegate?.nothingFound()
    }
    
}

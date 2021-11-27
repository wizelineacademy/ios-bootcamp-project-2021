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
}

class ListViewModel: NSObject {
    private let movieModel: MovieAPIModel
    private let movieFeed: MovieFeed
    private var movieList: [MovieViewModel] = []
    
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
        }
    }
    
    func didRefresh() {
        self.delegate?.didEndRefreshing()
    }
    
}

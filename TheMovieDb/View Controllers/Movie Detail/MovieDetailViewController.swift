//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

class MovieDetailViewController: UIViewController, MoviesDetailViewProtocol {
  
    
   
    var presenter: MoviesDetailPresenterProtocol?
    
    var movie: MovieProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = MovieDetailDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieDetail = self.movie else { return }
        self.presenter?.loadMovieDetail(movie: movieDetail)
    }
    
    func showDetailOf(movie: MovieDetailProtocol) {
        dataSource.movie = movie
        self.presenter?.loadSimilarMoviesFor(movie: movie)
    }
    
    func displaySimilarMovies(list: MovieList) {
        dataSource.similarMovies = list
        setUpView()
    }
    
    func setUpView() {
        self.title = movie?.title
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieDetail()
        collectionView.setup(dataSource: dataSource)
        collectionView.registerNibForCellWith(name: HeaderCollectionViewCell.identifierToDeque)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
    }
}

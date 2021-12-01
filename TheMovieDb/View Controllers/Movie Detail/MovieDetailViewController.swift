//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

class MovieDetailViewController: UIViewController, MoviesDetailViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = MovieDetailDataSource()
    let delegate = MovieDetailDelegate()
    var presenter: MoviesDetailPresenterProtocol?
    var movie: MovieProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movieDetail = self.movie else { return }
        self.presenter?.loadMovieDetail(movie: movieDetail)
        addDidSelectMovieClousure()
    }
    
    func showDetailOf(movie: MovieDetailProtocol) {
        dataSource.movie = movie
        delegate.movie = movie
        self.presenter?.loadSimilarMoviesFor(movie: movie)
    }
    
    func displaySimilarMovies(list: MovieList) {
        dataSource.similarMovies = list
        delegate.similarMovies = list
        setUpView()
    }
    
    func setUpView() {
        self.title = movie?.title
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieDetail()
        collectionView.setup(dataSource: dataSource)
        collectionView.setup(delegate: delegate)
        collectionView.registerNibForCellWith(name: HeaderCollectionViewCell.identifierToDeque)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
    
        let navigationItemReviews = UIBarButtonItem(image: UIImage(named: "reviews"), style: .plain, target: self, action: #selector(showReviewScreen))
        self.navigationItem.rightBarButtonItem = navigationItemReviews
        
    }
    
    func addDidSelectMovieClousure() {
        delegate.didSelectSimilarMovie = { [weak self] movie in
            self?.presenter?.didSelectSimilarMovie(movie: movie)
        }
    }
    
    @objc func showReviewScreen() {
        print("show reviews")
        if let movie = self.movie {
          presenter?.loadReviewsOf(movie: movie)
        }
    }
}

//
//  MoviesViewController.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import UIKit

class MoviesViewController: UIViewController, MoviesHomeViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    var dataSource = MoviesDataSource()
    var delegate = MoviesDelegate()
    var presenter: MoviesHomePresenterProtocol?
    let flowLayout = UICollectionViewFlowLayout()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpSpinner()
        presenter?.viewDidLoad()
    }

    func reloadViewWith(movies: MoviesFeed) {
        self.dataSource.feed = movies
        self.delegate.feed = movies
        self.collectionView.reloadData()
        self.spinner.stopAnimating()
    }
    
}

extension MoviesViewController {
    
    func setUpView() {
        self.title = "Movies" 
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovies()
        dataSource.identifier = MovieCollectionViewCell.identifierToDeque
        collectionView.setup(dataSource: dataSource)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.registerViewWith(name: HeaderCollectionReusableView.identifierToDeque)
        collectionView.setup(delegate: delegate)
        delegate.didSelectMovie = { movie in
            self.presenter?.didSelectMovie(movie: movie)
        }
    }
    
    func setUpSpinner() {
        spinner.center = self.collectionView.center
        self.view.addSubview(spinner)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
}

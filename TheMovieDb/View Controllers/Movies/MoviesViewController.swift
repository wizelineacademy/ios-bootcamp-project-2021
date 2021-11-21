//
//  MoviesViewController.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import UIKit

class MoviesViewController: UIViewController, MoviesHomeViewProtocol {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = MoviesDataSource()
    var delegate = MoviesDelegate()
    var presenter: MoviesHomePresenterProtocol?
    let flowLayout = UICollectionViewFlowLayout()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        presenter?.viewDidLoad()
    }

    func reloadViewWith(movies: MoviesFeed) {
        self.dataSource.feed = movies
        self.delegate.feed = movies
        self.collectionView.reloadData()
        
    }
    
}

extension MoviesViewController {
    
    func setUpView() {
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
    
}

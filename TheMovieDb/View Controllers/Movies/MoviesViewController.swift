//
//  MoviesViewController.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = MoviesDataSource()
    var delegate = MoviesDelegate()
    let flowLayout = UICollectionViewFlowLayout()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        requestMoviesFeed()
    }

}


extension MoviesViewController {
    
    func requestMoviesFeed() {
        
        let group = DispatchGroup()
        
        for topic in Topic.allCases {
            let request = Request(path: topic.getPath(), method: .get, group: group)
            
            MovieDbAPI.request(value: MovieList.self, request: request) { [weak self] list in
                guard let listOfMovies = list else { return }
                self?.dataSource.feed.addList(topic: topic, movieList: listOfMovies)
                self?.delegate.feed.addList(topic: topic, movieList: listOfMovies)
//                DispatchQueue.main.async {
//                    self?.collectionView.reloadData()
//                }
            }
        }
        
        group.notify(queue: .main) {
           // print("Completed work: \(movieIds)")
            // Kick off the movies API calls
            self.collectionView.reloadData()
          }
        
    }
    
    func setUpView() {
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovies()
        dataSource.identifier = MovieCollectionViewCell.identifierToDeque
        collectionView.setup(dataSource: dataSource)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.registerViewWith(name: HeaderCollectionReusableView.identifierToDeque)
        
        collectionView.setup(delegate: delegate)
        delegate.didSelectMovie = { movie in
             let storyboad = UIStoryboard(name: "Main", bundle: nil)
             guard let moviesDetsilViewController = storyboad.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return }
            moviesDetsilViewController.dataSource.movie = movie
            self.navigationController?.present(moviesDetsilViewController, animated: true, completion: nil)
        }
    }
    
}

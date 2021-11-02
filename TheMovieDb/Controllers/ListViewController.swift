//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ListViewController: UICollectionViewController {

    var movieClient: MovieClient!
    var movieList: MovieList?

    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: MovieCell.cellIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        //collectionView.reloadData()

        movieClient = MovieClient()

        // TODO: Make this call asynchronous
        if let tabIndex = self.tabBarController?.selectedIndex, let movieFeed = MovieFeed(rawValue: tabIndex) {
            self.movieClient.getFeed(from: movieFeed, searchId: nil, params: [
                "language": "en",
                "region": "US"
            ]) { result in
                switch result {
                case .success(let movieList):
                    guard let movieList = movieList else {
                        return
                    }
                    self.movieList = movieList
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("The error \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.results?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as? MovieCell else {
            preconditionFailure("Failed to load collection view cell")
        }
        
        guard let movie = movieList?.results?[indexPath.row] else {
            return cell
        }
        
        cell.movieImage.image = UIImage(named: "test_image")
        cell.movieTitle.text = movie.title
        if let voteAverage = movie.voteAverage {
            cell.movieRating.text = String(voteAverage)
        }
        
        return cell
    }
}

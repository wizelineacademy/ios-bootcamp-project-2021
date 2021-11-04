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

        movieClient = MovieClient()
        
        guard let tabIndex = self.tabBarController?.selectedIndex, let movieFeed = MovieFeed(rawValue: tabIndex) else {
            return
        }
        
        setupUI(movieFeed: movieFeed)
        
        fetchData(movieFeed: movieFeed)
        
    }
    
    private func setupUI(movieFeed: MovieFeed) {
        let cellNib = UINib(nibName: MovieCell.cellIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        
        title = movieFeed.getNavigationTitle()

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .black
        navbar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navbar.prefersLargeTitles = true
        
        // Set up the collection view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white

        // Set up the refresh control as part of the collection view when it's pulled to refresh.
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
    }
    
    private func fetchData(movieFeed: MovieFeed) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            self.movieClient.getFeed(from: movieFeed, searchId: nil, params: [:]) { result in
                switch result {
                case .success(let movieList):
                    guard let movieList = movieList else {
                        return
                    }
                    self.movieList = movieList
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else {
                            return
                        }
                        self.collectionView.reloadData()
                    }
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

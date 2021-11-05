//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ListViewController: UICollectionViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var movieClient: MovieClient!
    var movieList: MovieList?
    var configuration: ConfigurationWelcome?
    var selectedMovie: MovieItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieClient = MovieClient()
        
        guard let tabIndex = self.tabBarController?.selectedIndex, let movieFeed = MovieFeed(rawValue: tabIndex) else {
            return
        }
        
        setupUINavigation(movieFeed: movieFeed)
        setupUICollectionView()
        
        fetchConfiguration()
        fetchData(movieFeed: movieFeed)
        
    }
    
    private func setupUICollectionView() {
        let cellNib = UINib(nibName: MovieCell.cellIdentifier, bundle: .main)
        collectionView.register(cellNib, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        
        // Set up the collection view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.alwaysBounceVertical = true
        collectionView.indicatorStyle = .white
    }
    
    private func setupUINavigation(movieFeed: MovieFeed) {
        title = movieFeed.getNavigationTitle()

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .systemIndigo
        navbar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.prefersLargeTitles = true
        
        // Customize tab bar
        guard let tabBar = self.tabBarController?.tabBar else {
            return
        }
        
        tabBar.tintColor = .systemIndigo
    }
    
    private func fetchData(movieFeed: MovieFeed) {
        self.startAnimatingActivityIndicator()
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
                        self.stopAnimatingActivityIndicator()
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("The error \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchConfiguration() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {
                return
            }
            self.movieClient.getConfiguration { result in
                switch result {
                case .success(let configuration):
                    guard let configuration = configuration else {
                        return
                    }
                    self.configuration = configuration
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
    
    private func startAnimatingActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    private func stopAnimatingActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    // MARK: - CollectionView DataSource
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
        
        cell.movieItem = movie
        cell.configurationImages = configuration?.images
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let movie = movieList?.results?[indexPath.row] else {
            return false
        }
        self.selectedMovie = movie
        performSegue(withIdentifier: DetailViewController.segueIdentifier, sender: self)
        return true
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailViewController.segueIdentifier {
            let detailViewController = segue.destination as? DetailViewController
            detailViewController?.movieItem = selectedMovie
            detailViewController?.configurationImages = configuration?.images
        }
    }
}

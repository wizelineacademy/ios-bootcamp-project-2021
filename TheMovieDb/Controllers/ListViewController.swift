//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ListViewController: UIViewController {

    lazy private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .systemIndigo
        return view
    }()
    
    lazy private var collectionView: UICollectionView = {
        let layout = ColumnFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.alwaysBounceVertical = true
        collection.indicatorStyle = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var movieClient: MovieClient!
    var movieList: MovieList?
    var configuration: ConfigurationWelcome?
    
    // general margin for ui elements
    private let margin: CGFloat = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        movieClient = MovieClient()
        
        guard let tabIndex = self.tabBarController?.selectedIndex, let movieFeed = MovieFeed(rawValue: tabIndex) else {
            return
        }
        setupUI(movieFeed: movieFeed)
        
        fetchConfiguration()
        fetchData(movieFeed: movieFeed)
        
    }
    
    private func setupUI(movieFeed: MovieFeed) {
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        collectionView.register(MovieCellController.self, forCellWithReuseIdentifier: MovieCellController.cellIdentifier)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
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
                    print("The error fetchData \(error.localizedDescription)")
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
                    print("The error fetchConfiguration \(error.localizedDescription)")
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
    
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCellController.cellIdentifier, for: indexPath) as? MovieCellController else {
            preconditionFailure("Failed to load collection view cell")
        }
        
        guard let movie = movieList?.results?[indexPath.row] else {
            return cell
        }
        
        cell.movieItem = movie
        cell.configurationImage = configuration?.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let movie = movieList?.results?[indexPath.row] else {
            return false
        }
        if let configurationImage = configuration?.image {
            navigateTo(movie: movie, with: configurationImage)
            return true
        }
        return false
    }
    
    // MARK: - Navigation
    func navigateTo(movie: MovieItem, with configuration: ConfigurationImage) {
        let detailViewController = DetailViewController()
        detailViewController.movieItem = movie
        detailViewController.configurationImage = configuration
        
        guard let navigation = navigationController else {
            return
        }
        navigation.showDetailViewController(detailViewController, sender: self)
    }
}

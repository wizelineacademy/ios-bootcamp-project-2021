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
    
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search movie", delegate: self)
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    
    // general margin for ui elements
    private let margin: CGFloat = 10
    
    private var listView: ListView!
    private var listViewModel: ListViewModel!
    
    // Timer for the search
    private var searchTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tabIndex = self.tabBarController?.selectedIndex,
              let feedType = FeedType(rawValue: tabIndex) else {
            return
        }
        let movieFeed = MovieFeed(feedType: feedType)
        let movieAPIManager = MovieAPIManager(client: MovieAPIClient.shared)
        let model = MovieAPIModel(movieManager: movieAPIManager)
        listViewModel = ListViewModel(movieModel: model, movieFeed: movieFeed, delegate: self)
        listView = ListView(viewModel: listViewModel, navigationDelegate: self)
        
        setupUI(movieFeed: movieFeed)
    }
    
    private func setupUI(movieFeed: MovieFeed) {
        
        view.addSubview(listView.collectionView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            listView.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = movieFeed.getNavigationTitle()

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .systemIndigo
        navbar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.prefersLargeTitles = true

        // Set up the searchController parameters.
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Customize tab bar
        guard let tabBar = self.tabBarController?.tabBar else {
            return
        }
        
        tabBar.tintColor = .systemIndigo
    }
    
    private func addNothingFoundToSuperView() {
        view.addSubview(listView.nothingFoundView)
        
        NSLayoutConstraint.activate([
            listView.nothingFoundView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.nothingFoundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.nothingFoundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.nothingFoundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func removeNothingFoundFromSuperView() {
        listView.nothingFoundView.removeFromSuperview()
    }
    
}

// MARK: - UI Updates
extension ListViewController: ListViewModelDelegate {
    func didBeginRefreshing() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func didEndRefreshing() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
        removeNothingFoundFromSuperView()
        
        listView.collectionView.refreshControl?.endRefreshing()
        listView.collectionView.reloadData()
    }
    
    func nothingFound() {
        addNothingFoundToSuperView()
    }
}

// MARK: - Navigation
extension ListViewController: NavigationDelegate {
    func navigate(movieViewModel: MovieViewModel) {
        let detailViewController = DetailViewController(movieViewModel: movieViewModel)
        guard let navigation = navigationController else {
            return
        }
        navigation.showDetailViewController(detailViewController, sender: self)
    }
}

// MARK: - Search Bar
extension ListViewController: SearchBarDelegate {

    func updateSearchResults(for text: String) {
        guard !text.isEmpty else {
            return
        }
        
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
            var movieFeed = MovieFeed(feedType: .search)
            var params = movieFeed.params
            params["query"] = text
            movieFeed.params = params
            self?.changeFeed(to: movieFeed)
        })
    }
    
    func searchBarCancelledButton(_ searchBar: UISearchBar) {
        guard let tabIndex = self.tabBarController?.selectedIndex,
              let feedType = FeedType(rawValue: tabIndex) else {
            return
        }
        changeFeed(to: MovieFeed(feedType: feedType))
    }
    
    func changeFeed(to movieFeed: MovieFeed) {
        listViewModel.movieFeed = movieFeed
        listView.viewModel.refresh()
    }

}

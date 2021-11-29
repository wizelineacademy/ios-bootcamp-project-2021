//
//  HomeCollectionViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 10/11/21.
//

import UIKit

class HomeViewController: UIViewController, HomeView {
   
    var presenter: HomeViewPresenter?
    
    // Private Instances
    private var latestSearch: String?
    private var movieHomeCollectionView: GenericMovieCollectionView<SectionMovie>!
    
    // Lazy Vars
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a Movie", delegate: self)
        searchController.text = latestSearch
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    
    // Life Cycle Application
    override func viewDidLoad() {
        super.viewDidLoad()
   
        guard let navbar = self.navigationController?.navigationBar else { return }
        self.navigationItem.title = "Movies"
        navbar.tintColor = .black
        navbar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navbar.prefersLargeTitles = true

        navigationItem.searchController = searchController
        definesPresentationContext = true
        setUpCollectionView()
        presenter?.fetchAllMovieList()
    }
  
    // Methods To Configure Views
    func setUpCollectionView() {
        movieHomeCollectionView = GenericMovieCollectionView<SectionMovie>(frame: view.bounds)
        movieHomeCollectionView.delegateCollection = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        movieHomeCollectionView.refreshControl = refreshControl
        movieHomeCollectionView.sendSubviewToBack(refreshControl)
        view.addSubview(movieHomeCollectionView)
    }
    
  
    // Methods to conform HomeView
    func showEmptyState() {
        print("")
    }
    
    func showMoviesHome(arrMovie: [SectionMovie: [MovieViewModel]]) {
        movieHomeCollectionView.arrMovies = arrMovie
        movieHomeCollectionView.sections = Array(arrMovie.keys)
        movieHomeCollectionView.configureDataSource()
        movieHomeCollectionView.reloadData()
    }
    
   func showMoviesList(arrMovie: [Movie]) {
        //tableView.arrMovies = arrMovie
    }
    
    func showLoading() {
        print("")
    }
    
    func stopLoading() {
        guard
            let collectionView = movieHomeCollectionView,
            let refreshControl = collectionView.refreshControl
        else { return }

        refreshControl.endRefreshing()
    }
    
    // Actions
    @objc func refresh() {
        presenter?.fetchAllMovieList()
    }

}

extension HomeViewController: SearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //tableView.isHidden = true
    }
    
    func updateSearchResults(for text: String) {
        presenter?.searchMovie(strMovie: text)
    }
    
}

extension HomeViewController: GenericMovieCollectionViewDelegate {
    
    func selectedItem(movie: MovieViewModel) {
        presenter?.didSelectMovie(with: movie)
    }

}

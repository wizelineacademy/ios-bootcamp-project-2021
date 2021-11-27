//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by developer on 25/11/21.
//

import UIKit

class SearchViewController: UIViewController, SearchViewProtocol {
   
    var presenter: SearchViewPresenterProtocol?
    var dataSource = SearchDataSource()
    var delegate = SearchDelegate()
    
    @IBOutlet weak var collectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpSearchController()
        presenter?.viewDidLoad()
    }
    
    func setUpView() {
        self.title = "Search"
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMoviesSearch()
        collectionView.setup(dataSource: dataSource)
        collectionView.setup(delegate: delegate)
        dataSource.identifier = MovieCollectionViewCell.identifierToDeque
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
        delegate.didSelectMovie = { movie in
            self.presenter?.didSelectMovie(movie: movie)
        }
    }
    
    func setUpSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func reloadViewWithMovies(movies: MovieList) {
        self.dataSource.movieList = movies
        self.delegate.movieList = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
  
}

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      if searchController.searchBar.text == "" { return }
      guard let text = searchController.searchBar.text else { return }
      self.presenter?.search(text: text)
  }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter?.viewDidLoad()
    }
}

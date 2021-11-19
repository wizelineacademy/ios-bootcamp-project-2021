//
//  HomeCollectionViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 10/11/21.
//

import UIKit

class HomeViewController: UIViewController, HomeView {
   
    private var latestSearch: String?
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a Movie", delegate: self)
        searchController.text = latestSearch
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    
    var movieHomeCollectionView: GenericMovieCollectionView!
    var tableView: GenericTableViewController!
  
    func showEmptyState() {
        print("")
    }
    
    var presenter: HomeViewPresenter?
    
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
        setUpTableView()
        presenter?.fetchAllMovieList()
    }
    
    func setUpCollectionView() {
        movieHomeCollectionView = GenericMovieCollectionView(frame: view.bounds)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        movieHomeCollectionView.refreshControl = refreshControl
        movieHomeCollectionView.sendSubviewToBack(refreshControl)
        view.addSubview(movieHomeCollectionView)
    }
    
    func setUpTableView() {
        tableView = GenericTableViewController(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
     
        tableView.isHidden = true
        
    }
    
    @objc func refresh() {
        presenter?.fetchAllMovieList()
    }
    
    func showMoviesHome(arrMovie: [SectionMovie: [MovieViewModel]]) {
        movieHomeCollectionView.arrMovies = arrMovie
        movieHomeCollectionView.reloadData()
    }
    
    func showMoviesList(arrMovie: [Movie]) {
        tableView.arrMovies = arrMovie
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
    
}

extension HomeViewController: SearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
    }
    
    func updateSearchResults(for text: String) {
        presenter?.searchMovie(strMovie: text)
    }
    
}

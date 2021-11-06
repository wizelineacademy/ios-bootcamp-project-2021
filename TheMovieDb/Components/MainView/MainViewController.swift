//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChangeViewDelegate, UISearchResultsUpdating {
  
  @IBOutlet weak var tableView: UITableView?
  
  private var trendingMovies: [Movie] = []
  
  // All categories
  weak var coordinator: MainCoordinator?
  
  var circularViewDuration: TimeInterval = 2
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    setupTableView()
    setupSearch()
  }
  
  lazy private var searchController: SearchBar = {
      let searchController = SearchBar("Search a movie or an actor", delegate: nil)

      searchController.showsCancelButton = !searchController.isSearchBarEmpty
      return searchController
  }()
  
  // Navigation controller setup
  func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
//    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "Movies"
    navigationItem.searchController = searchController
  }
  
  func setupSearch() {
    searchController.searchResultsUpdater = self
  }
  // TableView Configuration
  func setupTableView() {
    if self.tableView != nil {
      self.tableView?.dataSource = self
      self.tableView?.delegate = self
      self.tableView?.separatorStyle = .none
      self.tableView?.showsVerticalScrollIndicator = false
      self.tableView?.showsHorizontalScrollIndicator = false
      self.tableView?.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
  }
  
  func setupShowDetail() {
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return CategoriesText.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else {
      return CategoryTableViewCell()
    }
    cell.delegate = self
    cell.configure(categoryTitle: CategoriesText.allCases[indexPath.row].rawValue, categories: Categories.allCases[indexPath.row])
    return cell
  }
  
  func changeDetailVC(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    coordinator?.showDetailMovie(movieTitle: movieTitle, movieScore: movieScore, posterPath: posterPath, overview: overview, id: id)
  }
  func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else { return }
//      filterContentForSearchText(text)
    }

//  private func filterContentForSearchText(_ searchText: String) {
//      // filter with a simple contains searched text
//      resultPokemons = pokemons.filter {
//              searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
//          }
//          .sorted {
//              $0.id < $1.id
//          }
//
//    tableView?.reloadData()
//  }
}

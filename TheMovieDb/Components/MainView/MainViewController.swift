//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChangeViewDelegate, UISearchResultsUpdating {
  
  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var resultTableView: UITableView?
  private var resultSearch: [Movie]?
  
  // All categories
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    setupTableView()
    setupSearch()
  }
  lazy private var searchController: SearchBar = {
    let searchTitle = NSLocalizedString("SEARCH_TITLE", comment: "Search Title")
    let searchController = SearchBar(searchTitle, delegate: nil)
    
    searchController.showsCancelButton = !searchController.isSearchBarEmpty
    return searchController
  }()
  
  // Navigation controller setup
  private func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
    //    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "Movies"
    navigationItem.searchController = searchController
  }
  
  private func setupSearch() {
    searchController.searchResultsUpdater = self
    
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    resultTableView?.refreshControl = refreshControl
    resultTableView?.sendSubviewToBack(refreshControl)
  }
  // TableView Configuration
  private func setupTableView() {
    if self.tableView != nil {
      self.tableView?.dataSource = self
      self.tableView?.delegate = self
      self.tableView?.separatorStyle = .none
      self.tableView?.showsVerticalScrollIndicator = false
      self.tableView?.showsHorizontalScrollIndicator = false
      self.tableView?.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
      
      self.resultTableView?.delegate = self
      self.resultTableView?.dataSource = self
      self.resultTableView?.register(ResultSearchTableViewCell.nib(), forCellReuseIdentifier: ResultSearchTableViewCell.identifier)
    }
    
  }
  override func viewWillAppear(_ animated: Bool) {
    refresh()
  }
  
  @objc func refresh() {
    if self.searchController.isSearchBarEmpty {
      self.tableView?.isHidden = false
      self.resultTableView?.isHidden = true
    } else {
      self.tableView?.isHidden = true
      self.resultTableView?.isHidden = false
      self.resultTableView?.reloadData()
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch tableView {
    case self.tableView:
      return CategoriesText.allCases.count
    case self.resultTableView:
      return self.resultSearch?.count ?? 0
    default:
      return CategoriesText.allCases.count
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch tableView {
    case self.tableView:
      guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else {
        return CategoryTableViewCell()
      }
      cell.delegate = self
      cell.configure(categoryTitle: CategoriesText.allCases[indexPath.row].rawValue, categories: Categories.allCases[indexPath.row])
      return cell
      
    case self.resultTableView:
      guard let cell = self.resultTableView?.dequeueReusableCell(withIdentifier: ResultSearchTableViewCell.identifier) as? ResultSearchTableViewCell else {
        return CategoryTableViewCell()
      }
      if !searchController.isSearchBarEmpty {
        cell.configure(movieTitle: resultSearch?[indexPath.row].title ?? "", posterPath: resultSearch?[indexPath.row].posterPath ?? "")
      }
      
      return cell
      
    default:
      guard let cell = self.tableView?.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else {
        return CategoryTableViewCell()
      }
      cell.delegate = self
      cell.configure(categoryTitle: CategoriesText.allCases[indexPath.row].rawValue, categories: Categories.allCases[indexPath.row])
      return cell
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == self.resultTableView {
      let movie = resultSearch?[indexPath.row]
      coordinator?.showDetailMovie(movieTitle: movie?.title ?? "", movieScore: movie?.voteAverage ?? 0, posterPath: movie?.posterPath ?? "", overview: movie?.overview ?? "", id: movie?.id ?? 0)
    }
  }
  
  func changeDetailVC(movieTitle: String, movieScore: Float, posterPath: String, overview: String, id: Int) {
    coordinator?.showDetailMovie(movieTitle: movieTitle, movieScore: movieScore, posterPath: posterPath, overview: overview, id: id)
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text else { return }
    self.requestAPISearch(text: text)
  }
  
  func requestAPISearch(text: String) {
    SearchRequester(searchText: text).requestAPI( completion: { movies in
      self.resultSearch = movies
      self.refresh()
    })
  }
  
}

//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var trendingMovies: [Movie] = []
  
  // All categories
  let categoriesData = ["Trending", "Now Playing", "Popular", "Top Rated", "Upcoming"]
  var circularProgressBarView: CircularProgressBarView!
  var circularViewDuration: TimeInterval = 2
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    setupTableView()
    setUpCircularProgressBarView()
  }
  
  lazy private var searchController: SearchBar = {
      let searchController = SearchBar("Search a movie or an actor", delegate: nil)
//      searchController.text = latestSearch
      searchController.showsCancelButton = !searchController.isSearchBarEmpty
      return searchController
  }()
  
  func setUpCircularProgressBarView() {
    // set view
    circularProgressBarView = CircularProgressBarView(frame: .zero)
    // align to the center of the screen
    circularProgressBarView.center = view.center
    // call the animation with circularViewDuration
    circularProgressBarView.progressAnimation(duration: circularViewDuration)
    // add this view to the view controller
    view.addSubview(circularProgressBarView)
  }
  
  // Navigation controller setup
  func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "Movies"
    navigationItem.searchController = searchController
  }
  
  // TableView Configuration
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    self.tableView.separatorStyle = .none
    self.tableView.showsVerticalScrollIndicator = false
    self.tableView.showsHorizontalScrollIndicator = false
    self.tableView.register(CategoryTableViewCell.nib(), forCellReuseIdentifier: CategoryTableViewCell.identifier)
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return CategoriesText.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell
    cell?.configure(categoryTitle: CategoriesText.allCases[indexPath.row].rawValue, categories: Categories.allCases[indexPath.row])
    return cell!
  }
}

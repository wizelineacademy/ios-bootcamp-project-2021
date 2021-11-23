//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 09/12/20.
//

import UIKit
import Combine

class FeedViewController: UICollectionViewController {
  
  static let categoryHeaderId = "categoryHeaderId"

  var apiClient: MovieClient
  var movieViewModel: GeneralMovieViewModel?
  
  var categoryMovies: [String: [MovieViewModel]] = [:]
  var searchResult: [MovieViewModel]? = []
  var titleCategory: String = ""
  
  private var lastSearch: String?
  
  lazy private var searchController: SearchBarController = {
    let searchController = SearchBarController(placeholder: "Search a Movie or an Actor", delegate: self)
    searchController.text = lastSearch
    searchController.showCancelButton = !searchController.isSearchBarEmpty
    return searchController
  }()
  
  init(apiClient: MovieClient) {
    self.apiClient = apiClient
    self.movieViewModel = GeneralMovieViewModel(movieClient: apiClient)
    super.init(collectionViewLayout: FeedViewController.createLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    getMovies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
  
  func setupNavigationBar() {
    navigationItem.searchController = searchController
    navigationItem.title = "MovieDB"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.tintColor = DesignColor.purple.color
  }
  // MARK: get data from the api using the viewModel
  func getMovies() {
    let group = DispatchGroup()
    for categories in MovieFeed.allCases {
      movieViewModel?.getListMovies(categories: categories, title: categories.title, group: group)
    }
    group.notify(queue: .main) {
      self.categoryMovies = self.movieViewModel!.listMovieViewModel
      self.collectionView.reloadData()
    }
  }

  func showTitleCategory(_ indexPath: IndexPath) -> String {
    
    let sectionType = MovieFeed.allCases[indexPath.section]
    switch sectionType {
    case .nowPlaying: return MovieFeed.nowPlaying.title
    case .popular: return MovieFeed.popular.title
    case .topRated: return MovieFeed.topRated.title
    case .trending: return MovieFeed.trending.title
    case .upcoming: return MovieFeed.upcoming.title
    }
  }
  // MARK: using the MovieFeed enum to return movie with indexPath
  func setMovie(with indexPath: IndexPath) -> MovieViewModel? {
    
    let sectionType = MovieFeed.allCases[indexPath.section]
    switch sectionType {
    case .nowPlaying: return categoryMovies[MovieFeed.nowPlaying.title]?[indexPath.item]
    case .popular: return categoryMovies[MovieFeed.popular.title]?[indexPath.item]
    case .topRated: return categoryMovies[MovieFeed.topRated.title]?[indexPath.item]
    case .trending: return categoryMovies[MovieFeed.trending.title]?[indexPath.item]
    case .upcoming: return categoryMovies[MovieFeed.upcoming.title]?[indexPath.item]
    }
  }
  
  private func searchMoviesOrActors(searchText: String) {
    
  }
  
}
  // MARK: CollectionView Configuration
extension FeedViewController {
  
  func setupCollectionView() {
    collectionView.backgroundColor = DesignColor.black.color
    collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identifier)
    collectionView.register(HeaderFeedView.self, forSupplementaryViewOfKind: FeedViewController.categoryHeaderId, withReuseIdentifier: HeaderFeedView.identifier)
    collectionView.showsVerticalScrollIndicator = false
  }
  // MARK: func to return a section for the compositional layout
  static func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { ( _, _ ) in
      
      let section = SectionBuilder()
      let margin: CGFloat = SizeAndMeasures.margin.measure
      let headerHeight: CGFloat = SizeAndMeasures.normalHeadersHeight.measure
      
      return section
        .createItemAndGroup(item: (0.9, 1), group: (SizeAndMeasures.movieCellSizeWidth.measure, SizeAndMeasures.movieCellSizeHeight.measure), groupAxis: .horizontal)
        .createSection()
        .constraints(type: .section, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: 0))
        .sectionBehavior(behavior: .continuous)
        .suplementaryView(width: 1, height: headerHeight, elementKind: categoryHeaderId, alignment: .topLeading)
        .build()
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return categoryMovies.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFeedView.identifier, for: indexPath) as? HeaderFeedView else { fatalError("problems with HeaderFeedView")}
    header.label.text = showTitleCategory(indexPath)
    return header
  }
  // MARK: enum of MovieFeed to manage numberOfItemInSection
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let sectionType = MovieFeed.allCases[section]
    
    switch sectionType {
    case .nowPlaying: return categoryMovies[MovieFeed.nowPlaying.title]?.count ?? 0
    case .popular: return categoryMovies[MovieFeed.popular.title]?.count ?? 0
    case .topRated: return categoryMovies[MovieFeed.topRated.title]?.count ?? 0
    case .trending: return categoryMovies[MovieFeed.trending.title]?.count ?? 0
    case .upcoming: return categoryMovies[MovieFeed.upcoming.title]?.count ?? 0
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath)
        as? MovieViewCell else { fatalError("problems find it the cell") }
    
    if let movie = setMovie(with: indexPath) {
      cell.movie = movie
    }
    return cell
  }
  
  // MARK: - Navigation to detailViewController
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let movie = setMovie(with: indexPath) else { return }
    let detailVC = DetailViewController(movieClient: apiClient, movieId: movie.id)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}

extension FeedViewController: SearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
  
  func searchBarTextDidEndEditing(_ searcBar: UISearchBar) {}
  
  func updateSearchResults(with text: String) {
    searchMoviesOrActors(searchText: text)
  }
}

//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 09/12/20.
//

import UIKit

class FeedViewController: UICollectionViewController {
  
  static let categoryHeaderId = "categoryHeaderId"
  // MARK: presente to manage the logic part of the app
  var moviePresenter: MoviePresenter?
  
  var categoryMovies: [String: [Movie]] = [:]
  var searchResult: [Movie]? = []
  var titleCategory: String = ""
  private var lastSearch: String?
  lazy private var searchController: SearchBarController = {
    let searchController = SearchBarController(placeholder: "Search a Movie or an Actor", delegate: self)
    searchController.text = lastSearch
    searchController.showCancelButton = !searchController.isSearchBarEmpty
    return searchController
  }()
  
  init() {
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
  // MARK: get data from the api using the presenter
  func getMovies() {
    for categories in MovieFeed.allCases {
      moviePresenter?.getData(from: categories, kindItem: MovieFeedResult.self, complement: categories.title)
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
  func setMovie(with indexPath: IndexPath) -> Movie? {
    
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
    let detailVC = DetailViewController()
    guard let movie = setMovie(with: indexPath) else { return }
    let movieDetailPresenter = MoviePresenter(view: detailVC)
    detailVC.movieDetailPresenter = movieDetailPresenter
    detailVC.movieId = movie.id
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
}
  // MARK: protocol to connect the view with the presenter
extension FeedViewController: MoviePresenterDelegate {
  
  var complement: String? {
    get { return titleCategory }
    set { titleCategory = newValue ?? "" }
  }
  
  func showResults<Element>(items: Element) {
    guard let movies = items as? MovieFeedResult, let listMovies = movies.results, let complement = complement else { return }
    self.categoryMovies[complement] = listMovies
    DispatchQueue.main.async { [weak self]  in
      self?.collectionView.reloadData()
    }
  }
  
}

extension FeedViewController: SearchBarDelegate {
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
  
  func searchBarTextDidEndEditing(_ searcBar: UISearchBar) {}
  
  func updateSearchResults(with text: String) {
    searchMoviesOrActors(searchText: text)
  }
}

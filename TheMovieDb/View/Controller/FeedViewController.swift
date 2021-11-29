//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 09/12/20.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
  
  static let categoryHeaderId = "categoryHeaderId"

  var apiClient: MovieClient
  var movieViewModel: MovieRepository?
  
  var categoryMovies: [String: [MovieViewModel]] = [:]
  var searchResult: [MovieViewModel] = []
  var titleCategory: String = ""
  
  var timer: Timer?
  
  private var lastSearch: String?
  
  var feedCollectionView: UICollectionView! = nil
  
  lazy private var searchController: SearchBarController = {
    let searchController = SearchBarController(placeholder: "Search a Movie or an Actor", delegate: self)
    searchController.text = lastSearch
    searchController.showCancelButton = !searchController.isSearchBarEmpty
    searchController.searchBar.searchTextField.textColor = .white
    return searchController
  }()
  
  init(apiClient: MovieClient) {
    self.apiClient = apiClient
    self.movieViewModel = MovieRepository(movieClient: apiClient)
    super.init(nibName: nil, bundle: nil)
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
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.barTintColor = DesignColor.black.color
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    navigationController?.navigationBar.tintColor = DesignColor.purple.color
  }
  // MARK: get data from the api using the viewModel

  func getMovies() {
    let group = DispatchGroup()
    for categories in MovieFeed.allCases {
      group.enter()
      movieViewModel?.getDataMovies(categories: categories, group: group, kindOfElement: MovieFeedResult.self, complete: { [weak self] movies in
        defer { group.leave() }
        guard let listMovies = movies.results else { return }
        self?.categoryMovies[categories.title] = listMovies.map({ movie in
          MovieViewModel(movie: movie)
        })
      })
    }
    group.notify(queue: .main) {
      self.feedCollectionView.reloadData()
    }
  }

  func showTitleCategory(_ indexPath: IndexPath) -> String {
    if searchResult.count == 0 {
      let sectionType = MovieFeed.allCases[indexPath.section]
      switch sectionType {
      case .nowPlaying: return MovieFeed.nowPlaying.title
      case .popular: return MovieFeed.popular.title
      case .topRated: return MovieFeed.topRated.title
      case .trending: return MovieFeed.trending.title
      case .upcoming: return MovieFeed.upcoming.title
      }
    } else {
      return "Current Search"
    }
  }
  // MARK: using the MovieFeed enum to return movie with indexPath
  func setMovie(with indexPath: IndexPath) -> MovieViewModel? {
    if searchResult.count == 0 {
      let sectionType = MovieFeed.allCases[indexPath.section]
      switch sectionType {
      case .nowPlaying: return categoryMovies[MovieFeed.nowPlaying.title]?[indexPath.item]
      case .popular: return categoryMovies[MovieFeed.popular.title]?[indexPath.item]
      case .topRated: return categoryMovies[MovieFeed.topRated.title]?[indexPath.item]
      case .trending: return categoryMovies[MovieFeed.trending.title]?[indexPath.item]
      case .upcoming: return categoryMovies[MovieFeed.upcoming.title]?[indexPath.item]
      }
    } else {
      return searchResult[indexPath.item]
    }
  }

}
  // MARK: CollectionView Configuration
extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  
  func setupCollectionView() {
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    view.addSubview(collectionView)
    collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = DesignColor.black.color
    collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identifier)
    collectionView.register(HeaderFeedView.self, forSupplementaryViewOfKind: FeedViewController.categoryHeaderId, withReuseIdentifier: HeaderFeedView.identifier)
    collectionView.showsVerticalScrollIndicator = false
    feedCollectionView = collectionView
  }
  // MARK: func to return a section for the compositional layout
  func createLayout() -> UICollectionViewLayout {
    
    let layout = UICollectionViewCompositionalLayout { [weak self] ( _, _ ) -> NSCollectionLayoutSection? in
      guard let self = self else { fatalError("problems with self")}
      let section = SectionBuilder()
      let margin: CGFloat = SizeAndMeasures.margin.measure
      let headerHeight: CGFloat = SizeAndMeasures.normalHeadersHeight.measure
      if self.searchResult.isEmpty {
        return section
          .createItemAndGroup(item: (0.9, 1), group: (SizeAndMeasures.movieCellSizeWidth.measure, SizeAndMeasures.movieCellSizeHeight.measure), groupAxis: .horizontal)
          .createSection()
          .constraints(type: .section, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: 0))
          .sectionBehavior(behavior: .continuous)
          .suplementaryView(width: 1, height: headerHeight, elementKind: FeedViewController.categoryHeaderId, alignment: .topLeading)
          .build()
      } else {
        return section
          .createItem(width: 0.33, height: 0.2)
          .constraints(type: .item, contentInsets: .init(top: 0, leading: 0, bottom: margin, trailing: margin))
          .createGroup(width: 1, height: UIScreen.main.bounds.height, groupAxis: .horizontal)
          .createSection()
          .constraints(type: .section, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: 0))
          .suplementaryView(width: 1, height: headerHeight, elementKind: FeedViewController.categoryHeaderId, alignment: .topLeading)
          .build()
      }
    }
    return layout
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return (searchResult.count == 0) ? categoryMovies.count : 1
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFeedView.identifier, for: indexPath) as? HeaderFeedView else { fatalError("problems with HeaderFeedView")}
    header.label.text = showTitleCategory(indexPath)
    return header
  }
  // MARK: enum of MovieFeed to manage numberOfItemInSection
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if searchResult.count == 0 {
      let sectionType = MovieFeed.allCases[section]
      switch sectionType {
      case .nowPlaying: return categoryMovies[MovieFeed.nowPlaying.title]?.count ?? 0
      case .popular: return categoryMovies[MovieFeed.popular.title]?.count ?? 0
      case .topRated: return categoryMovies[MovieFeed.topRated.title]?.count ?? 0
      case .trending: return categoryMovies[MovieFeed.trending.title]?.count ?? 0
      case .upcoming: return categoryMovies[MovieFeed.upcoming.title]?.count ?? 0
      }
    } else {
      return searchResult.count
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath)
        as? MovieViewCell else { fatalError("problems find it the cell") }
    
    if let movie = setMovie(with: indexPath) { cell.movie = movie }
    return cell
  }
  
  // MARK: - Navigation to detailViewController
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let movie = setMovie(with: indexPath) else { return }
    let detailVC = DetailViewController(movieClient: apiClient, movieId: movie.id)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  
}

extension FeedViewController: SearchBarDelegate {

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {}
  
  func updateSearchResults(_ searchBar: UISearchBar, with text: String) {
    if !text.isEmpty && searchResult.isEmpty {
      if timer != nil { timer?.invalidate() }
      var runCount = 0
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
        runCount += 1
        if runCount == 2 {
          timer.invalidate()
          runCount = 0
          self?.searchMovies(searchText: text)
          searchBar.searchTextField.resignFirstResponder()
        }
      }
    } else if searchResult.count != 0 && text == "" {
      searchResult.removeAll()
      searchBar.showsCancelButton = false
      DispatchQueue.main.async { [weak self] in
        self?.feedCollectionView.reloadData()
      }
    }
  }
  
  private func searchMovies(searchText: String) {
    searchResult.removeAll()
    let group = DispatchGroup()
    group.enter()
    movieViewModel?.getDataMovies(categories: SearchKeyword.keywords, search: searchText, group: group, kindOfElement: MovieFeedResult.self, complete: { [weak self] movieSearch in
      defer { group.leave() }
      guard let resultSearch = movieSearch.results else { return }
      self?.searchResult = resultSearch.map({ movie in
        MovieViewModel(movie: movie)
      })
    })
    
    group.notify(queue: .main) { [weak self] in
      self?.feedCollectionView.reloadData()
    }
  }
}

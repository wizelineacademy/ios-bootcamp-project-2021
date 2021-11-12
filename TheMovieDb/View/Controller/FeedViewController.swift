//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 09/12/20.
//

import UIKit
import SwiftUI

class FeedViewController: UICollectionViewController {
  
  static let categoryHeaderId = "categoryHeaderId"
  
  var moviePresenter: MoviePresenter?
  
  var categoryMovies: [String: [Movie]] = [:]
  var titleCategory: String = ""
 
  init() {
    super.init(collectionViewLayout: FeedViewController.createLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "MovieDB"

    setupCollectionView()
    getMovies()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
  }

  func setupCollectionView() {
    collectionView.backgroundColor = DesignColor.black.color
    collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identifier)
    collectionView.register(HeaderFeedView.self, forSupplementaryViewOfKind: FeedViewController.categoryHeaderId, withReuseIdentifier: HeaderFeedView.identifier)
    collectionView.showsVerticalScrollIndicator = false
  }
 
  func getMovies() {
    for categories in MovieFeed.allCases {
      moviePresenter?.getData(from: categories, movieRegion: .US, movieLanguage: .en, kindItem: MovieFeedResult.self, complement: categories.title)
    }
  }
  
  static func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { ( _, _ ) in
      
      let section = SectionBuilder()
      return section
        .createItem(width: 0.9, height: 1)
        .createGroup(width: 0.40, height: 260, axis: .horizontal)
        .createSection()
        .sectionConstraints(top: 0, leading: 20, bottom: 0, trailing: 0)
        .sectionBehavior(behavior: .continuous)
        .suplementaryView(width: 1, height: 60, elementKind: categoryHeaderId, alignment: .topLeading)
        .build()

    }
  }
  
  func showTitleCategory(_ indexPath: IndexPath) -> String {
    var title = ""
    for (index, category) in MovieFeed.allCases.enumerated() where indexPath.section == index {
      title = category.title
    }
    return title
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return categoryMovies.count
  }

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderFeedView.identifier, for: indexPath) as? HeaderFeedView else { fatalError("problems with HeaderFeedView")}
    header.label.text = showTitleCategory(indexPath)
    return header
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0: return categoryMovies[MovieFeed.nowPlaying.title]?.count ?? 0
    case 1: return categoryMovies[MovieFeed.popular.title]?.count ?? 0
    case 2: return categoryMovies[MovieFeed.topRated.title]?.count ?? 0
    case 3: return categoryMovies[MovieFeed.trending.title]?.count ?? 0
    case 4: return categoryMovies[MovieFeed.upcoming.title]?.count ?? 0
    default: return 0
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
  
  func setMovie(with indexPath: IndexPath) -> Movie? {

    var movie: Movie?
    
    switch indexPath.section {
    case 0:
      movie = categoryMovies[MovieFeed.nowPlaying.title]?[indexPath.item]
    case 1:
      movie = categoryMovies[MovieFeed.popular.title]?[indexPath.item]
    case 2:
      movie = categoryMovies[MovieFeed.topRated.title]?[indexPath.item]
    case 3:
      movie = categoryMovies[MovieFeed.trending.title]?[indexPath.item]
    case 4:
      movie = categoryMovies[MovieFeed.upcoming.title]?[indexPath.item]
    default:
      movie = categoryMovies[MovieFeed.nowPlaying.title]?[indexPath.item]
    }
    return movie!
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    guard let movie = setMovie(with: indexPath) else { return }
    let movieDetailPresenter = MoviePresenter(view: detailVC)
    detailVC.movieDetailPresenter = movieDetailPresenter
    detailVC.movieId = movie.id
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
}

extension FeedViewController: MoviePresenterDelegate {
  
  var complement: String? {
    get {
      return titleCategory
    }
    set (newValue) {
      titleCategory = newValue ?? ""
    }
  }

  func showResults<Element>(items: Element) {
    guard let movies = items as? MovieFeedResult, let listMovies = movies.results, let complement = complement else { return }
    self.categoryMovies[complement] = listMovies
    DispatchQueue.main.async { [weak self]  in
      self?.collectionView.reloadData()
    }
  }

}

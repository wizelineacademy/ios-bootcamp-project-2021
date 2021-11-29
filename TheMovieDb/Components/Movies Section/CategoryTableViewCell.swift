//
//  CategoryTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet private var categoryLabel: UILabel?
  @IBOutlet private var collectionView: UICollectionView?
  
  private var movies: [Categories: [Movie]] = [:]
  
  private var category: Categories?
  private var movieId: Int?
  
  static let identifier = "CategoryTableViewCell"
  weak var delegate: ChangeViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpUI()
    setupCollectionView()
    requestAPI()
  }
  
  private func requestAPI() {
    RequesterCategories().requestAPI { movies in
      self.movies = movies
      self.collectionView?.reloadData()
    }
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "CategoryTableViewCell", bundle: nil)
  }
  
  func configure(categoryTitle: String, categories: Categories?) {
    self.categoryLabel?.text = categoryTitle
    
    if let categoriesVar = categories {
      self.category = categoriesVar
    }
  }
  
  private func setUpUI() {
    categoryLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    categoryLabel?.textColor = .label
  }
  
  private func setupCollectionView() {
    self.collectionView?.dataSource = self
    self.collectionView?.delegate = self
    self.collectionView?.showsHorizontalScrollIndicator = false
    self.collectionView?.showsVerticalScrollIndicator = false
    self.collectionView?.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
  }
  
  // Collection View
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var movie: Movie?
    guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
      return MovieCollectionViewCell()
    }
  
    switch self.category {
    case .trendingMovies:
      movie = movies[.trendingMovies]?[indexPath.row]
    case .nowPlayingMovies:
      movie = movies[.nowPlayingMovies]?[indexPath.row]
    case .popularMovies:
      movie = movies[.popularMovies]?[indexPath.row]
    case .topRatedMovies:
      movie = movies[.topRatedMovies]?[indexPath.row]
    case .upcomingMovies:
      movie = movies[.upcomingMovies]?[indexPath.row]
    case .none:
      movie = movies[.upcomingMovies]?[indexPath.row]
    }
    
    cell.configure(MovieViewModel(movie))
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var movieViewModel: MovieViewModel?
    switch self.category {
    case .popularMovies:
      movieViewModel = MovieListViewModel(movies: movies[.popularMovies]).movieAtIndex(indexPath.row)
    case .trendingMovies:
      movieViewModel = MovieListViewModel(movies: movies[.trendingMovies]).movieAtIndex(indexPath.row)
    case .nowPlayingMovies:
      movieViewModel = MovieListViewModel(movies: movies[.nowPlayingMovies]).movieAtIndex(indexPath.row)
    case .topRatedMovies:
      movieViewModel = MovieListViewModel(movies: movies[.topRatedMovies]).movieAtIndex(indexPath.row)
    case .upcomingMovies:
      movieViewModel = MovieListViewModel(movies: movies[.upcomingMovies]).movieAtIndex(indexPath.row)
    case .none:
      movieViewModel = MovieListViewModel(movies: movies[.upcomingMovies]).movieAtIndex(indexPath.row)
    }
    
    delegate?.changeDetailVC(movieViewModel: movieViewModel)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch self.category {
    case .trendingMovies:
      return MovieListViewModel(movies: movies[.trendingMovies]).numberRows()
    case .nowPlayingMovies:
      return MovieListViewModel(movies: movies[.nowPlayingMovies]).numberRows()
    case .popularMovies:
      return MovieListViewModel(movies: movies[.popularMovies]).numberRows()
    case .topRatedMovies:
      return MovieListViewModel(movies: movies[.topRatedMovies]).numberRows()
    case .upcomingMovies:
      return MovieListViewModel(movies: movies[.upcomingMovies]).numberRows()
    case .none:
      return 0
    }
  }
  
}

//
//  CategoryTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var categoryLabel: UILabel?
  @IBOutlet weak var collectionView: UICollectionView?
  
  private var trendingMovies: [Movie] = []
  private var nowPlayingMovies: [Movie] = []
  private var popularMovies: [Movie] = []
  private var topRatedMovies: [Movie] = []
  private var upcomingMovies: [Movie] = []
  
  private var movies: [Categories: [Movie]] = [:]
  
  private var categories: Categories = .trendingMovies
  
  static let identifier = "CategoryTableViewCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpUI()
    setupCollectionView()
    requestAPI()
  }
  
  private func requestAPI() {
    Requester().requestAPI { movies in
      self.movies = movies
      print("MAIN")
      print(movies)
      self.collectionView?.reloadData()
    }
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "CategoryTableViewCell", bundle: nil)
  }
  
  func configure(categoryTitle: String, categories: Categories) {
    self.categoryLabel?.text = categoryTitle
    self.categories = categories
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setUpUI() {
    categoryLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    categoryLabel?.textColor = .label
  }
  
  func setupCollectionView() {
    self.collectionView?.dataSource = self
    self.collectionView?.delegate = self
    self.collectionView?.showsHorizontalScrollIndicator = false
    self.collectionView?.showsVerticalScrollIndicator = false
    self.collectionView?.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
  }
  
  // Collection View
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
      return MovieCollectionViewCell()
    }
    switch self.categories {
    case .trendingMovies:
      cell.configure(movieTitle: movies[.trendingMovies]?[indexPath.row].title ?? "", movieScore: movies[.trendingMovies]?[indexPath.row].voteAverage ?? 0.0, posterPath: movies[.trendingMovies]?[indexPath.row].posterPath ?? "")
      
    case .nowPlayingMovies:
      cell.configure(movieTitle: movies[.nowPlayingMovies]?[indexPath.row].title ?? "", movieScore: movies[.nowPlayingMovies]?[indexPath.row].voteAverage ?? 0.0, posterPath: movies[.nowPlayingMovies]?[indexPath.row].posterPath ?? "")
    case .popularMovies:
      cell.configure(movieTitle: movies[.popularMovies]?[indexPath.row].title ?? "", movieScore: movies[.popularMovies]?[indexPath.row].voteAverage ?? 0.0, posterPath: movies[.popularMovies]?[indexPath.row].posterPath ?? "")
    case .topRatedMovies:
      cell.configure(movieTitle: movies[.topRatedMovies]?[indexPath.row].title ?? "", movieScore: movies[.topRatedMovies]?[indexPath.row].voteAverage ?? 0.0, posterPath: movies[.topRatedMovies]?[indexPath.row].posterPath ?? "")
    case .upcomingMovies:
      cell.configure(movieTitle: movies[.upcomingMovies]?[indexPath.row].title ?? "", movieScore: movies[.upcomingMovies]?[indexPath.row].voteAverage ?? 0.0, posterPath: movies[.upcomingMovies]?[indexPath.row].posterPath ?? "")
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch self.categories {
    case .trendingMovies:
      return movies[.trendingMovies]?.count ?? 0
    case .nowPlayingMovies:
      return movies[.nowPlayingMovies]?.count ?? 0
    case .popularMovies:
      return movies[.popularMovies]?.count ?? 0
    case .topRatedMovies:
      return movies[.topRatedMovies]?.count ?? 0
    case .upcomingMovies:
      return movies[.upcomingMovies]?.count ?? 0
    }
  }
}

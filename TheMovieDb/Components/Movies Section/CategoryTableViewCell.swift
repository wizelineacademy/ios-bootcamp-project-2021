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
  
  private var movies: [Categories: [Movie]] = [:]
  private var recommendedMovies: [Recommendations: [Movie]] = [:]
  
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
    
    cell.configure(movieTitle: movie?.title ?? "", movieScore: movie?.voteAverage ?? 0.0, posterPath: movie?.posterPath ?? "", overview: movie?.overview ?? "", id: movie?.id ?? 0)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var movie: Movie?
    switch self.category {
    case .popularMovies:
      movie = movies[.popularMovies]?[indexPath.row]
    case .trendingMovies:
      movie = movies[.trendingMovies]?[indexPath.row]
    case .nowPlayingMovies:
      movie = movies[.nowPlayingMovies]?[indexPath.row]
    case .topRatedMovies:
      movie = movies[.topRatedMovies]?[indexPath.row]
    case .upcomingMovies:
      movie = movies[.upcomingMovies]?[indexPath.row]
    case .none:
      movie = movies[.upcomingMovies]?[indexPath.row]
    }
    
    delegate?.changeDetailVC(movieTitle: movie?.title ?? "", movieScore: movie?.voteAverage ?? 0, posterPath: movie?.posterPath ?? "", overview: movie?.overview ?? "", id: movie?.id ?? 0)
    
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch self.category {
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
    case .none:
      return 0
    }
  }
  
}

//
//  CategoryTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 29/10/21.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var categoryTitle: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  private var trendingMovies: [Movie] = []
  private var nowPlayingMovies: [Movie] = []
  private var popularMovies: [Movie] = []
  private var topRatedMovies: [Movie] = []
  private var upcomingMovies: [Movie] = []
  
  private var categories: Categories = .trendingMovies
  
  static let identifier = "CategoryTableViewCell"
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpUI()
    setupCollectionView()
    requestAPI()
    // Initialization code
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//      self.collectionView.reloadData()
//    }
  }
  
  // Request for trending movies
  private func requestAPITrending() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.trendingMovies = response.results
          print(response)
          self?.collectionView.reloadData()
          
        default:
          self?.trendingMovies = []
        }
    }
    API.getTrendingMovies.resume(completion: completion)
  }
  
  private func requestAPINowPlaying() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.nowPlayingMovies = response.results
          print(response)
          self?.collectionView.reloadData()
          
        default:
          self?.nowPlayingMovies = []
        }
    }
    API.getNowPlayingMovies.resume(completion: completion)
  }
  
  private func requestAPIPopular() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.popularMovies = response.results
          print(response)
          self?.collectionView.reloadData()
          
        default:
          self?.popularMovies = []
        }
    }
    API.getPopularMovies.resume(completion: completion)
  }
  
  private func requestAPITopRated() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.topRatedMovies = response.results
          print(response)
          self?.collectionView.reloadData()
          
        default:
          self?.topRatedMovies = []
        }
    }
    API.getTopRatedMovies.resume(completion: completion)
  }
  
  private func requestAPIUpcoming() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          print("Upcoming \(response)")
          self?.upcomingMovies = response.results
          print(response)
          self?.collectionView.reloadData()
          
        default:
          print("Upcoming not found")
          self?.upcomingMovies = []
        }
    }
    API.getUpcomingMovies.resume(completion: completion)
  }
  
  private func requestAPI() {
    requestAPITrending()
    requestAPIPopular()
    requestAPIUpcoming()
    requestAPITopRated()
    requestAPINowPlaying()
  }
  
  static func nib() -> UINib {
    return UINib(nibName: "CategoryTableViewCell", bundle: nil)
  }
  
  func configure(categoryTitle: String, categories: Categories) {
    self.categoryTitle.text = categoryTitle
    self.categories = categories
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setUpUI() {
    categoryTitle.font = UIFont.boldSystemFont(ofSize: 20)
    categoryTitle.textColor = .black
  }
  
  func setupCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    self.collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
  }
  
  // Collection View
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
    switch self.categories {
    case .trendingMovies:
      cell?.configure(movieTitle: trendingMovies[indexPath.row].title, movieScore: trendingMovies[indexPath.row].voteAverage)
    case .nowPlayingMovies:
      cell?.configure(movieTitle: nowPlayingMovies[indexPath.row].title, movieScore: nowPlayingMovies[indexPath.row].voteAverage)
    case .popularMovies:
      cell?.configure(movieTitle: popularMovies[indexPath.row].title, movieScore: popularMovies[indexPath.row].voteAverage)
    case .topRatedMovies:
      cell?.configure(movieTitle: topRatedMovies[indexPath.row].title, movieScore: topRatedMovies[indexPath.row].voteAverage)
    case .upcomingMovies:
      cell?.configure(movieTitle: upcomingMovies[indexPath.row].title, movieScore: upcomingMovies[indexPath.row].voteAverage)
    }
    
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch self.categories {
    case .trendingMovies:
      return trendingMovies.count
    case .nowPlayingMovies:
      return nowPlayingMovies.count
    case .popularMovies:
      return popularMovies.count
    case .topRatedMovies:
      return topRatedMovies.count
    case .upcomingMovies:
      return upcomingMovies.count
    }
  }
}

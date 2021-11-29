//
//  RecommendedTableViewCell.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 04/11/21.
//

import UIKit

final class RecommendedTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var typeLabel: UILabel?
  @IBOutlet weak var collectionView: UICollectionView?
  
  static let identifier = "RecommendedTableViewCell"
  private var type: Recommendations?
  private var movies: [Recommendations?: [Movie?]]?
  private var id: Int?
  weak var delegate: ChangeViewDelegate?
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpUI()
    setupCollectionView()
    // Initialization code
  }
  
  private func setUpUI() {
    typeLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    typeLabel?.textColor = .label
  }
  static func nib() -> UINib {
    return UINib(nibName: "RecommendedTableViewCell", bundle: nil)
  }
  private func setupCollectionView() {
    self.collectionView?.dataSource = self
    self.collectionView?.delegate = self
    self.collectionView?.showsHorizontalScrollIndicator = false
    self.collectionView?.showsVerticalScrollIndicator = false
    self.collectionView?.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
    
    if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
        layout.scrollDirection = .horizontal
    }
  }
  
  private func requestAPI() {
    RecommendationRequester().requestAPI(id: self.id ?? 0) { movies in
      self.movies = movies
      self.collectionView?.reloadData()
      if movies[self.type!]?.count == 0 {
        self.isHidden = true
      }
    }
  }
  
  func configure(title: String, type: Recommendations, id: Int) {
    self.typeLabel?.text = title
    self.type = type
    self.id = id
    requestAPI()
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch self.type {
    case .recommendedMovies:
      return movies?[.recommendedMovies]?.count ?? 0
    case .similarMovies:
      return movies?[.similarMovies]?.count ?? 0
    case .none:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
      return MovieCollectionViewCell()
    }
    switch self.type {
    case .recommendedMovies:
      if let movie = movies?[.recommendedMovies]?[indexPath.row] {
        cell.configure(movieTitle: movie.title, movieScore: movie.voteAverage, posterPath: movie.posterPath ?? "", overview: movie.overview, id: movie.id)
      }
      
    case .similarMovies:
      if let movie = movies?[.similarMovies]?[indexPath.row] {
        cell.configure(movieTitle: movie.title, movieScore: movie.voteAverage, posterPath: movie.posterPath ?? "", overview: movie.overview, id: movie.id)
      }
    case .none:
      cell.configure(movieTitle: "", movieScore: 0, posterPath: "", overview: "", id: 0)
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var movie: Movie?
    switch self.type {
    case .recommendedMovies:
      movie = movies?[.recommendedMovies]?[indexPath.row]
      
    case .similarMovies:
      movie = movies?[.similarMovies]?[indexPath.row]
     
    case .none:
      movie = movies?[.recommendedMovies]?[indexPath.row]
    }
    delegate?.changeDetailVC(movieTitle: movie?.title ?? "", movieScore: movie?.voteAverage ?? 0, posterPath: movie?.posterPath ?? "", overview: movie?.overview ?? "", id: movie?.id ?? 0)
  }
  
}

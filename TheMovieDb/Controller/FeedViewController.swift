//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 09/12/20.
//

import UIKit

class FeedViewController: UICollectionViewController {
  
  var arrayMovies = [Movie]()
  
  var databaseManager: MovieDBClient?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationController()
    setupCollectionView()
    getData()
  }
  
  func setupCollectionView() {
    
    collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    collectionView.backgroundColor = DesignColor.black.color
    collectionView.delegate = self
    collectionView.dataSource = self
    let layout = UICollectionViewFlowLayout()
    collectionView.collectionViewLayout = layout
    
  }
  
  func setupNavigationController() {
    self.title = "Popular"
    navigationController?.navigationBar.isTranslucent = false
    let backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    navigationItem.backBarButtonItem = backBarButtonItem
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = DesignColor.black.color
    appearance.titleTextAttributes = [.foregroundColor: DesignColor.white.color]
    appearance.largeTitleTextAttributes = [.foregroundColor: DesignColor.white.color]
    
    navigationController?.navigationBar.tintColor = DesignColor.white.color
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
  
  func didRefresh() {
    DispatchQueue.main.async {
      self.collectionView.reloadData()
    }
    
  }
  
  // get data from the network to fill the feed
  func getData() {
    databaseManager?.getData(from: MovieFeed.popular, movieRegion: .US, movieLanguage: .en) { [weak self] (result: Result<MovieFeedResult?, ApiError>) in
      switch result {
      case .success(let movieFeedResult):
        guard let movieResults = movieFeedResult?.results else { return }
        self?.arrayMovies = movieResults
        self?.didRefresh()
      case .failure(let error):
        print("the error \(error)")
      }
    }
  }
  
  // get movie details and showing the detailView
  func getDetailMovie(movieId: Int) {
    databaseManager?.getData(from: InfoById.movieDetails(movieId: movieId), movieRegion: nil, movieLanguage: nil) { [weak self] (result: Result<MovieDetails?, ApiError>) in
      switch result {
      case .success(let movieDetails):
        guard let movieResults = movieDetails else { return }
        self?.showDetailMovie(movieDetails: movieResults)
      case .failure(let error):
        print("the error \(error)")
      }
    }
  }
  
  func showDetailMovie(movieDetails: MovieDetails) {
    if let detailView = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController {
      detailView.movie = movieDetails
      navigationController?.pushViewController(detailView, animated: true)
    }
  }
  
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayMovies.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {return MovieCollectionViewCell()}
    cell.movie = arrayMovies[indexPath.item]
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let movie = arrayMovies[indexPath.item]
    self.getDetailMovie(movieId: movie.id)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height = UIScreen.main.bounds.width / 1.3 + 20
    let width = UIScreen.main.bounds.width / 2 - 30
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 20, left: 20, bottom: 20, right: 20)
  }
}

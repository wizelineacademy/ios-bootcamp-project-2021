//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class FeedViewController: UICollectionViewController {
  
  var arrayMovies = [Movie]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    getData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationController()
  }
  
  func setupCollectionView(){
    
    collectionView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    collectionView.backgroundColor = .init(white: 0.1, alpha: 0.8)
    collectionView.delegate = self
    collectionView.dataSource = self
    let layout = UICollectionViewFlowLayout()
    collectionView.collectionViewLayout = layout
    
  }
  
  func setupNavigationController(){
    self.title = "Popular"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .black
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
  }
  
  func didRefresh(){
    self.collectionView.reloadData()
  }
  
  
  
  func getData(){
    MovieDBClient.shared.getData(from: MovieFeed.popular, movieRegion: .US, movieLanguage: .en) { [weak self] (result: Result<MovieFeedResult?, ApiError>) in
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
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayMovies.count
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
    cell.movie = arrayMovies[indexPath.item]  
    return cell
  }
  
}

extension FeedViewController: UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let height = UIScreen.main.bounds.width / 1.3 + 20
    let width = UIScreen.main.bounds.width / 2 - 30
    
    return CGSize(width: width, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 20, left: 20, bottom: 20, right: 20)
  }
}



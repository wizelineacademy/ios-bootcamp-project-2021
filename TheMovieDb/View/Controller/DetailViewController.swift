//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/3/21.
//

import UIKit
import SwiftUI

class DetailViewController: UICollectionViewController {
  
  var movieId: Int?
  var seccion = ""
  
  var movieDetailPresenter: MoviePresenter?
  var movieDetails: MovieDetails?
  var cast: [Person] = []
  var reviews: [MovieReview] = []
  var similarMovies: [SimilarOrRecommendedMovie] = []
  var recommendedMovies: [SimilarOrRecommendedMovie] = []
  
  init() {
    super.init(collectionViewLayout: DetailViewController.createLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  static let categoryTopHeaderId = "categoryTopHeaderId"
  static let categoryTitleHeaderView = "categoryTitleHeaderView"
  let sections = ["Title", "Overview", "Cast", "Reviews", "Similar Movies", "Recommended Movies"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = movieDetails?.title
    setupCollectionView()
    getMovieDetails()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.barTintColor = DesignColor.black.color
  }
  
  func setupCollectionView() {
    collectionView.backgroundColor = DesignColor.black.color
    // register Cells
    collectionView.register(ExtraInfoCell.self, forCellWithReuseIdentifier: ExtraInfoCell.identifier)
    collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: OverviewCell.identifier)
    collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.identifier)
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
    // register Headers
    collectionView.register(TopHeaderDetailView.self, forSupplementaryViewOfKind: DetailViewController.categoryTopHeaderId, withReuseIdentifier: TopHeaderDetailView.identifier)
    collectionView.register(TitleHeaderDetailView.self, forSupplementaryViewOfKind: DetailViewController.categoryTitleHeaderView, withReuseIdentifier: TitleHeaderDetailView.identifier)
    collectionView.showsVerticalScrollIndicator = false
  }

  static func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, _ ) in
      
      let section = SectionBuilder()
      let margin: CGFloat = 20
      let headerHeight: CGFloat = 80
      switch sectionNumber {
      case 0 :
        return section
          .createItem(width: 1, height: 1)
          .createGroup(width: 1, height: 120, axis: .vertical)
          .createSection()
          .suplementaryView(width: 1, height: UIScreen.main.bounds.width, elementKind: categoryTopHeaderId, alignment: .topLeading)
          .build()
      case 1, 2:
        return section
          .createItem(width: 1, height: 1)
          .createGroup(width: 1, height: 100, axis: .horizontal)
          .groupConstraints(top: 0, leading: margin, bottom: 0, trailing: margin)
          .createSection()
          .sectionBehavior(behavior: .paging)
          .suplementaryView(width: 1, height: headerHeight, elementKind: categoryTitleHeaderView, alignment: .topLeading)
          .build()
      case 3:
        return section
          .createItem(width: 1, height: 1)
          .createGroup(width: 1, height: 190, axis: .horizontal)
          .groupConstraints(top: 0, leading: margin, bottom: 0, trailing: margin)
          .createSection()
          .sectionBehavior(behavior: .paging)
          .suplementaryView(width: 1, height: headerHeight, elementKind: categoryTitleHeaderView, alignment: .topLeading)
          .build()
      default:
        return section
          .createItem(width: 1, height: 1)
          .createGroup(width: 0.40, height: 260, axis: .horizontal)
          .groupConstraints(top: 0, leading: margin, bottom: 0, trailing: 0)
          .createSection()
          .sectionConstraints(top: 0, leading: 0, bottom: 0, trailing: margin)
          .sectionBehavior(behavior: .continuous)
          .suplementaryView(width: 1, height: headerHeight, elementKind: categoryTitleHeaderView, alignment: .topLeading)
          .build()
      }
    }
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }
  
  func showTitleCategory(_ indexPath: IndexPath) -> String {
    var title = ""
    for (index, category) in sections.enumerated() where indexPath.section == index {
      title = category
    }
    return title
  }
  
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

    if indexPath.section == 0 {
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopHeaderDetailView.identifier, for: indexPath) as? TopHeaderDetailView else { fatalError("some problem with TopHeader") }
      header.movieDetails = self.movieDetails
      return header
    } else {
      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderDetailView.identifier, for: indexPath) as? TitleHeaderDetailView else { fatalError("some problem with TitleHeaderView") }
      header.titleLabel.text = showTitleCategory(indexPath)
      return header
    }

  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0: return 1
    case 1: return 1
    case 2: return cast.count
    case 3: return reviews.count
    case 4: return similarMovies.count
    case 5: return recommendedMovies.count
    default:
      return 0
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.section == 0 {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtraInfoCell.identifier, for: indexPath) as? ExtraInfoCell
      else { fatalError("some problem with ExtraInfoCell") }
      
      cell.movieDetails = movieDetails
      return cell
      
    } else if indexPath.section == 1 {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCell.identifier, for: indexPath) as? OverviewCell
      else { fatalError("some problem with OverviewCell") }
      
      cell.movieDetails = movieDetails
      return cell
      
    } else if indexPath.section == 2 {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.identifier, for: indexPath) as? CastCell
      else { fatalError("some problem with CastCell") }
      
      let person = cast[indexPath.item]
      cell.person = person
      return cell
      
    } else if indexPath.section == 3 {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell
      else { fatalError("some problem with ReviewCell") }
      
      let review = reviews[indexPath.item]
      cell.review = review
      return cell
      
    } else {
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
      else { fatalError("some problem with MovieCell") }
      
      if indexPath.section == 4 {
        let movie = similarMovies[indexPath.item]
        cell.similarOrRecommendeMovie = movie
      } else if indexPath.section == 5 {
        let movie = recommendedMovies[indexPath.item]
        cell.similarOrRecommendeMovie = movie
      }
      return cell
      
    }
    
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
  
  func getMovieDetails() {
    guard let movieId = self.movieId else { return }
    movieDetailPresenter?.getData(from: InfoById.movieDetails(movieId), movieRegion: nil, movieLanguage: nil, kindItem: MovieDetails.self, complement: MovieDetailSections.movieDetails.title)
    movieDetailPresenter?.getData(from: InfoById.credits(movieId), movieRegion: nil, movieLanguage: nil, kindItem: Credits.self, complement: MovieDetailSections.cast.title)
    movieDetailPresenter?.getData(from: InfoById.reviews(movieId), movieRegion: nil, movieLanguage: nil, kindItem: ListReviews.self, complement: MovieDetailSections.reviews.title)
    movieDetailPresenter?.getData(from: InfoById.similar(movieId), movieRegion: nil, movieLanguage: nil, kindItem: ListSimilarOrRecommendedMovies.self, complement: MovieDetailSections.similarMovies.title)
    movieDetailPresenter?.getData(from: InfoById.recommendations(movieId), movieRegion: nil, movieLanguage: nil, kindItem: ListSimilarOrRecommendedMovies.self, complement: MovieDetailSections.recommendedMovies.title)
  }
  
}

extension DetailViewController: MoviePresenterDelegate {
  
  var complement: String? {
    get {
      return seccion
    }
    set (newValue) {
      seccion = newValue ?? ""
    }
  }

  func showResults<Element>(items: Element) {
    let dispatchGroup = DispatchGroup()
    dispatchGroup.enter()
    switch complement {
    case .none:
      print("anything here")
    case .some("Movie Details"):
      guard let movieDetail = items as? MovieDetails else { return }
      self.movieDetails = movieDetail
    case .some("Cast"):
      guard let cast = items as? Credits, let listCast = cast.cast else { return }
      self.cast = listCast
    case .some("Reviews"):
      guard let reviews = items as? ListReviews, let listReview = reviews.results else { return }
      self.reviews = listReview
    case .some("Similar Movies"):
      guard let similarMovies = items as? ListSimilarOrRecommendedMovies, let listMovies = similarMovies.results else { return }
      self.similarMovies = listMovies
    case .some("Recommendations"):
      guard let recommendedMovies = items as? ListSimilarOrRecommendedMovies, let listRecommendedMovies = recommendedMovies.results else { return }
      self.recommendedMovies = listRecommendedMovies
    default:
      print("sorry we have a problem")
    }
    dispatchGroup.leave()
    
    dispatchGroup.notify(queue: .main) {
      self.collectionView.reloadData()
    }
  }

}

//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/3/21.
//

import UIKit
import Combine
import CloudKit

class DetailViewController: UIViewController {
  
  var movieId: Int?
  var movieClient: MovieClient
  var movieVM: MovieDetailsViewModel?
  
  var movieDetails: GeneralMovieViewModel?
  var listCast: ListCastViewModel?
  var listReview: ListReviewsViewModel?
  var listSimilarMovies: GeneralMovieViewModel?
  var listRecommendedMovies: GeneralMovieViewModel?
  
  var cast: [PersonViewModel]? = []
  var reviews: [ReviewViewModel]? = []
  var similarMovies: [MovieViewModel]? = []
  var recommendedMovies: [MovieViewModel]? = []
  
  static let categoryTopHeaderId = "categoryTopHeaderId"
  static let categoryTitleHeaderView = "categoryTitleHeaderView"
  var detailCollectionView: UICollectionView! = nil
  
  init(movieClient: MovieClient, movieId: Int) {
    self.movieClient = movieClient
    self.movieId = movieId
    self.movieDetails = GeneralMovieViewModel(movieClient: movieClient)
    self.listCast = ListCastViewModel(movieClient: movieClient)
    self.listReview = ListReviewsViewModel(movieClient: movieClient)
    self.listSimilarMovies = GeneralMovieViewModel(movieClient: movieClient)
    self.listRecommendedMovies = GeneralMovieViewModel(movieClient: movieClient)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    getAllInfoDetailMovie()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNavigationBar()
  }
  // MARK: initial configuration NavigationController
  func setupNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = DesignColor.black.color
  }
  // MARK: returning header title depending of its section with MovieSection enum
  func showTitleCategory(_ indexPath: IndexPath) -> String {
    let section = MovieSection.allCases[indexPath.section]
    switch section {
    case .extrainfo: return MovieSection.extrainfo.title
    case .overview: return MovieSection.overview.title
    case .cast: return MovieSection.cast.title
    case .reviews: return MovieSection.reviews.title
    case .similar: return MovieSection.similar.title
    case .recommended: return MovieSection.recommended.title
    }
  }
//  var cancellables: Set<AnyCancellable> = []
  // MARK: get data from the api using the presenter
//  func getMovieDetails() {
//    guard let id = movieId else { return }
//    movieClient.fetch(InfoById.movieDetails(id), kindItem: MovieDetails.self)
//      .receive(on: RunLoop.main)
//      .sink(receiveCompletion: { _ in },
//            receiveValue: { [weak self] movieDetails in
//            guard let self = self else { return }
//            self.movieDetails = MovieDetailsViewModel(movieDetails: movieDetails)
//      })
//      .store(in: &cancellables)
//  }
  
  func getAllInfoDetailMovie() {
    guard let id = movieId else { return }
    let group = DispatchGroup()
    group.enter()
    movieDetails?.getMovieDetails(categories: InfoById.movieDetails(id), group: group)
    group.leave()
    group.enter()
    listCast?.getCast(categories: InfoById.credits(id), group: group)
    group.leave()
    group.enter()
    listReview?.getReviews(categories: InfoById.reviews(id), group: group)
    group.leave()
    group.enter()
    listSimilarMovies?.getSimilarOrRecommendedMovies(categories: InfoById.similar(id), group: group)
    group.leave()
    group.enter()
    listRecommendedMovies?.getSimilarOrRecommendedMovies(categories: InfoById.recommendations(id), group: group)
    group.leave()
    
    group.notify(queue: .main) {
      self.updateInfo()
    }
  }
  
  func updateInfo() {
    guard
      let movieDetails = self.movieDetails?.movieDetails,
      let similar = self.listSimilarMovies?.listSimilarOrRecommendedViewModel,
      let recommended = self.listRecommendedMovies?.listSimilarOrRecommendedViewModel,
      let credits = self.listCast?.listCastViewModel,
      let reviews = self.listReview?.listReviewsViewModel
    else { return }
    self.movieVM = movieDetails
    self.similarMovies = similar
    self.recommendedMovies = recommended
    self.cast = credits
    self.reviews = reviews
    refreshView()
  }
  
  func refreshView() {

    DispatchQueue.main.async {
      self.detailCollectionView.reloadData()
    }
  }
  
}

// MARK: CollectionView Configuration
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  // MARK: initial configuration in the collectionView
  func setupCollectionView() {
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    view.addSubview(collectionView)
    collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = DesignColor.black.color
    // register Cells
    collectionView.register(ExtraInfoCell.self, forCellWithReuseIdentifier: ExtraInfoCell.identifier)
    collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: OverviewCell.identifier)
    collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.identifier)
    collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.identifier)
    collectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identifier)
    // register Headers
    collectionView.register(TopHeaderDetailView.self, forSupplementaryViewOfKind: DetailViewController.categoryTopHeaderId, withReuseIdentifier: TopHeaderDetailView.identifier)
    collectionView.register(TitleHeaderDetailView.self, forSupplementaryViewOfKind: DetailViewController.categoryTitleHeaderView, withReuseIdentifier: TitleHeaderDetailView.identifier)
    collectionView.showsVerticalScrollIndicator = false
    detailCollectionView = collectionView
  }

  // MARK: func to return a layout with sections for the compositionalLayout
  func createLayout() -> UICollectionViewLayout {
    
    let layout = UICollectionViewCompositionalLayout { [weak self] (sectionNumber, _ ) -> NSCollectionLayoutSection? in
      
      guard let self = self else { fatalError("problem with self") }
      let category = MovieSection.allCases[sectionNumber]
      let heightOverview = SizeAndMeasures.cellWithTextHeight(self.movieVM?.overview ?? "", .paragraph, SizeAndMeasures.sizeScreen.measure - 40).measure
      let margin: CGFloat = SizeAndMeasures.margin.measure
      let categoryHeaderHeight: CGFloat = SizeAndMeasures.normalHeadersHeight.measure
      let topHeaderHeight: CGFloat = SizeAndMeasures.topHeadersHeight.measure
      let movieSimilarAndRecommendedHeight = SizeAndMeasures.movieCellSizeHeight.measure
      
      switch category {
      case .extrainfo:
        return self.generateTopHeaderSection(margin: margin, headerHeight: topHeaderHeight)
      case .overview:
        return self.generateOverviewLayout(margin: margin, headerHeight: categoryHeaderHeight, groupHeight: heightOverview)
      case .cast:
        guard let list = self.cast?.isEmpty else { return nil }
        return self.generateLayoutCastReviews(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: 100)
      case .reviews:
        guard let list = self.reviews?.isEmpty else { return nil }
        return self.generateLayoutCastReviews(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: 120)
      case .similar:
        guard let list = self.similarMovies?.isEmpty else { return nil }
        return self.generateLayoutLisMovies(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: movieSimilarAndRecommendedHeight)
      case .recommended:
        guard let list = self.recommendedMovies?.isEmpty else { return nil }
        return self.generateLayoutLisMovies(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: movieSimilarAndRecommendedHeight)
      }
    }
    return layout
  }
  // MARK: returning section TopHeaderSection
  func generateTopHeaderSection(margin: CGFloat, headerHeight: CGFloat) -> NSCollectionLayoutSection? {
    let section = SectionBuilder()
    return section
      .createItemAndGroup(item: (w: 1, h: 1), group: (w: 1, h: 120), groupAxis: .vertical)
      .createSection()
      .suplementaryView(width: 1, height: headerHeight, elementKind: DetailViewController.categoryTopHeaderId, alignment: .topLeading)
      .build()
  }
  
  // MARK: returning section depending the size of the UILabel
  func generateOverviewLayout(margin: CGFloat, headerHeight: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection? {
    let section = SectionBuilder()
    return section
      .createItemAndGroup(item: (w: 1, h: 1), group: (w: 1, h: groupHeight), groupAxis: .horizontal)
      .constraints(type: .group, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: margin))
      .createSection()
      .suplementaryView(width: 1, height: headerHeight, elementKind: DetailViewController.categoryTitleHeaderView, alignment: .topLeading)
      .build()
  }
  
  // MARK: returning section depending if the data has or not cast and reviews inside
  func generateLayoutCastReviews(listMovies: Bool, margin: CGFloat, headerHeight: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection? {
    let section = SectionBuilder()
    return section
      .createItemAndGroup(item: (w: 1, h: 1), group: (w: 1, h: listMovies ? 0 : groupHeight), groupAxis: .horizontal)
      .constraints(type: .group, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: margin))
      .createSection()
      .sectionBehavior(behavior: .paging)
      .suplementaryView(width: 1, height: listMovies ? 0 : headerHeight, elementKind: DetailViewController.categoryTitleHeaderView, alignment: .topLeading)
      .build()
  }
  
  // MARK: returning section depending if the data has or not movies inside
  func generateLayoutLisMovies(listMovies: Bool, margin: CGFloat, headerHeight: CGFloat, groupHeight: CGFloat) -> NSCollectionLayoutSection? {
    let section = SectionBuilder()
    return section
      .createItemAndGroup(item: (w: 1, h: 1), group: (w: 0.45, h: listMovies ? 0 : groupHeight), groupAxis: .horizontal)
      .constraints(type: .group, contentInsets: .init(top: 0, leading: margin, bottom: 0, trailing: 0))
      .createSection()
      .sectionBehavior(behavior: .continuous)
      .constraints(type: .section, contentInsets: .init(top: 0, leading: 0, bottom: 0, trailing: margin))
      .suplementaryView(width: 1, height: listMovies ? 0 : listMovies ? 0 : headerHeight, elementKind: DetailViewController.categoryTitleHeaderView, alignment: .topLeading)
      .build()
  }
  // MARK: Using MovieSection enum to determine the amount of section in the detailController
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return MovieSection.allCases.count
  }
  // MARK: Setting the corresponding header with the MovieSection enum
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let sectionType = MovieSection.allCases[indexPath.section]
    switch sectionType {
    case .extrainfo:
      guard let header = detailCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TopHeaderDetailView.identifier, for: indexPath) as? TopHeaderDetailView else { fatalError("some problem with TopHeader") }
      header.movieDetails = self.movieVM
      return header
    case .overview, .cast, .reviews, .similar, .recommended:
      guard let header = detailCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderDetailView.identifier, for: indexPath) as? TitleHeaderDetailView else { fatalError("some problem with TitleHeaderView") }
      header.titleLabel.text = showTitleCategory(indexPath)
      return header
    }
  }
  // MARK: enum of MovieSection to manage numberOfItemInSection
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let sectionType = MovieSection.allCases[section]
    switch sectionType {
    case .extrainfo: return 1
    case .overview: return 1
    case .cast: return cast?.count ?? 0
    case .reviews: return reviews?.count ?? 0
    case .similar: return similarMovies?.count ?? 0
    case .recommended: return recommendedMovies?.count ?? 0
    }
  }
  // MARK: setupCell depending of its kind of cell
  private func setupCell<GenericCell: BaseCell>(indexpath: IndexPath, cell: GenericCell.Type, identifier: String) -> GenericCell {
    guard let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexpath) as? GenericCell
    else { fatalError("some problem with BaseCell") }
    return cell
  }
  // MARK: returning the cell choosen to set the corresponding data of each cell
  private func chooseCellForSection(_ indexPath: IndexPath) -> UICollectionViewCell {
    let sectionType = MovieSection.allCases[indexPath.section]
    switch sectionType {
    case .extrainfo:
      let cell = self.setupCell(indexpath: indexPath, cell: ExtraInfoCell.self, identifier: ExtraInfoCell.identifier)
      cell.movieDetails = movieVM
      return cell
    case .overview:
      let cell = self.setupCell(indexpath: indexPath, cell: OverviewCell.self, identifier: OverviewCell.identifier)
      cell.movieDetails = movieVM
      return cell
    case .cast:
      let cell = self.setupCell(indexpath: indexPath, cell: CastCell.self, identifier: CastCell.identifier)
      if let person = cast?[indexPath.item] { cell.person = person }
      return cell
    case .reviews:
      let cell = self.setupCell(indexpath: indexPath, cell: ReviewCell.self, identifier: ReviewCell.identifier)
      if let review = reviews?[indexPath.item] { cell.review = review }
      return cell
    case .similar:
      let cell = self.setupCell(indexpath: indexPath, cell: MovieViewCell.self, identifier: MovieViewCell.identifier)
      if let movie = similarMovies?[indexPath.item] { cell.movie = movie }
      return cell
    case .recommended :
      let cell = self.setupCell(indexpath: indexPath, cell: MovieViewCell.self, identifier: MovieViewCell.identifier)
      if let movie = recommendedMovies?[indexPath.item] { cell.movie = movie }
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return chooseCellForSection(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let sectionType = MovieSection.allCases[indexPath.section]
    switch sectionType {
    case .extrainfo, .overview:
      print("no interaction")
    case .cast:
      print(cast?[indexPath.item].character as Any)
    case .reviews:
      print(reviews?[indexPath.item].content as Any)
    case .similar:
      guard let movie = similarMovies?[indexPath.item] else { return }
      let detailVC = DetailViewController(movieClient: movieClient, movieId: movie.id)
      self.navigationController?.pushViewController(detailVC, animated: true)
    case .recommended:
      guard let movie = recommendedMovies?[indexPath.item] else { return }
      let detailVC = DetailViewController(movieClient: movieClient, movieId: movie.id)
      self.navigationController?.pushViewController(detailVC, animated: true)
    }
  }
}

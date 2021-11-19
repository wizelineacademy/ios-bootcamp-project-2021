//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/3/21.
//

import UIKit

class DetailViewController: UIViewController {
  
  var movieId: Int?
  var seccion = ""

  // MARK: presente to manage the logic part of the app
  var movieDetailPresenter: MoviePresenter?
  var movieDetails: MovieDetails?
  
  static let categoryTopHeaderId = "categoryTopHeaderId"
  static let categoryTitleHeaderView = "categoryTitleHeaderView"
  var detailCollectionView: UICollectionView! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    getMovieDetails()
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
  // MARK: get data from the api using the presenter
  func getMovieDetails() {
    guard let movieId = self.movieId else { return }
    movieDetailPresenter?.getData(from: InfoById.movieDetails(movieId), kindItem: MovieDetails.self)
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
    collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
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
      let heightOverview = SizeAndMeasures.cellWithTextHeight(self.movieDetails?.overview ?? "", .paragraph, SizeAndMeasures.sizeScreen.measure - 40).measure
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
        guard let list = self.movieDetails?.cast?.isEmpty else { return nil }
        return self.generateLayoutCastReviews(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: 100)
      case .reviews:
        guard let list = self.movieDetails?.reviews?.isEmpty else { return nil }
        return self.generateLayoutCastReviews(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: 120)
      case .similar:
        guard let list = self.movieDetails?.similarMovies?.isEmpty else { return nil }
        return self.generateLayoutLisMovies(listMovies: list, margin: margin, headerHeight: categoryHeaderHeight, groupHeight: movieSimilarAndRecommendedHeight)
      case .recommended:
        guard let list = self.movieDetails?.recommendedMovies?.isEmpty else { return nil }
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
      header.movieDetails = self.movieDetails
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
    case .cast: return  movieDetails?.cast!.count ?? 0
    case .reviews: return  movieDetails?.reviews!.count ?? 0
    case .similar: return  movieDetails?.similarMovies!.count ?? 0
    case .recommended: return  movieDetails?.recommendedMovies!.count ?? 0
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
      cell.movieDetails = movieDetails
      return cell
    case .overview:
      let cell = self.setupCell(indexpath: indexPath, cell: OverviewCell.self, identifier: OverviewCell.identifier)
      cell.movieDetails = movieDetails
      return cell
    case .cast:
      let cell = self.setupCell(indexpath: indexPath, cell: CastCell.self, identifier: CastCell.identifier)
      if let person = movieDetails?.cast![indexPath.item] { cell.person = person }
      return cell
    case .reviews:
      let cell = self.setupCell(indexpath: indexPath, cell: ReviewCell.self, identifier: ReviewCell.identifier)
      if let review = movieDetails?.reviews![indexPath.item] { cell.review = review }
      return cell
    case .similar:
      let cell = self.setupCell(indexpath: indexPath, cell: MovieCell.self, identifier: MovieCell.identifier)
      if let movie = movieDetails?.similarMovies![indexPath.item] { cell.similarOrRecommendeMovie = movie }
      return cell
    case .recommended :
      let cell = self.setupCell(indexpath: indexPath, cell: MovieCell.self, identifier: MovieCell.identifier)
      if let movie = movieDetails?.recommendedMovies![indexPath.item] { cell.similarOrRecommendeMovie = movie }
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return chooseCellForSection(indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print(indexPath)
  }
  
}

// MARK: Presenter Delegate
extension DetailViewController: MoviePresenterDelegate {
  
  func showResults<Element>(items: Element) {
    guard let movie = items as? MovieDetails else { return }
    self.movieDetailPresenter?.completeMovieDetails(movieDetails: movie) { [weak self] completeDetailMovie in
      self?.movieDetails = completeDetailMovie
      DispatchQueue.main.async {
        self?.detailCollectionView.reloadData()
      }
    }
  }
}

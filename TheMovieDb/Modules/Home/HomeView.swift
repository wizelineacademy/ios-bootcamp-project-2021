//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit
import OSLog

enum FeedTypes {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case keyword
    case search
}

private extension FeedTypes {
    var feedTitle: String {
        switch self {
        case .trending: return "home.feed.trending.title".localized
        case .nowPlaying: return "home.feed.nowPlaying.title".localized
        case .popular: return "home.feed.popular.title".localized
        case .topRated: return "home.feed.topRated.title".localized
        case .upcoming: return "home.feed.upcoming.title".localized
        case .keyword: return "home.feed.keyword.title".localized
        case .search: return "home.feed.search.title".localized
        }
    }
}

final class HomeView: UIViewController {
    
    var presenter = HomeViewPresenter()
    
    @IBOutlet weak var feedType: UICollectionView!
    
    @IBOutlet weak var movieFeed: UICollectionView!
    
    lazy var loader = LoadingViewController()
    
    lazy private var searchController = UISearchController()
    
    private lazy var moviesDataSource = makeDataSource()
    
    enum Section: Int, CaseIterable {
        case all
    }
    
    let normalFeeds: [FeedTypes] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
    
    let searchFeeds: [FeedTypes] = [.search, .keyword]
    
    private var firstLoaded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "home.navigation.title".localized
        presenter.delegate = self
        configureSearch()
        configureFeedCollection()
        configureTypesCollection()
        presenter.getMoviesIfNeeded(search: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLoaded {
            selectFirstFeedType()
            firstLoaded = false
        }
    }
    
    func configureTypesCollection() {
        feedType.allowsMultipleSelection = false
        feedType.dataSource = self
        feedType.delegate = self
        feedType.backgroundColor = .clear
    }
    
    func configureFeedCollection() {
        movieFeed.collectionViewLayout = makeCollectionViewLayout()
        movieFeed.dataSource = moviesDataSource
        movieFeed.delegate = self
    }
    
    func configureSearch() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.delegate = self
    }
    
    func selectFirstFeedType() {
        feedType.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension HomeView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if presenter.isSearching {
            return searchFeeds.count
        } else {
            return normalFeeds.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedTypeCell.cellIdentifier,
            for: indexPath
        ) as? FeedTypeCell
        if presenter.isSearching {
            cell?.updateUI(withFeedTitle: searchFeeds[indexPath.row].feedTitle)
        } else {
            cell?.updateUI(withFeedTitle: normalFeeds[indexPath.row].feedTitle)
        }
        return cell ?? UICollectionViewCell()
    }
    
}

extension HomeView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        switch collectionView {
        case movieFeed:
            if indexPath.row == collectionView.numberOfItems(inSection: 0) - 1 {
                presenter.getMoviesIfNeeded(search: nil)
            }
        default:
            break
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch collectionView {
        case movieFeed:
            guard let selectedMovie = moviesDataSource.itemIdentifier(for: indexPath) else {
                return
            }
            let viewModel = DetailViewModel(
                dependencies: DetailViewModel.Dependencies(movie: selectedMovie)
            )
            let vc = DetailView(viewModel: viewModel)
            viewModel.delegate = vc
            navigationController?.pushViewController(vc, animated: true)
        case feedType:
            presenter.currentFeed = presenter.isSearching ? searchFeeds[indexPath.row] : normalFeeds[indexPath.row]
        default:
            break
        }
    }
}

private extension HomeView {
    func makeDataSource() -> UICollectionViewDiffableDataSource<Section, Movie> {
        return UICollectionViewDiffableDataSource(
            collectionView: movieFeed
        ) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoviesFeedCell.cellIdentifier,
                for: indexPath
            ) as? MoviesFeedCell
            cell?.updateUI(withMovie: movie)
            return cell
        }
    }
    
    func makeGridLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1)
        ))

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.5)
            ),
            subitem: item,
            count: 2
        )
        
        return NSCollectionLayoutSection(group: group)
    }
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, _ in
            switch Section(rawValue: sectionIndex) {
            case .all:
                return self?.makeGridLayoutSection()
            default:
                return nil
            }
        }
    }
    
    func updateFeed(withMovies movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(movies)
        moviesDataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text else {
            return
        }
        presenter.getMoviesIfNeeded(search: search)
    }
}

extension HomeView: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        presenter.isSearching = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        presenter.isSearching = false
    }
}

extension HomeView: HomeViewPresenterDelegate {
    
    func didStartLoading() {
        add(loader)
    }
    
    func didFinishLoading() {
        loader.remove()
    }
    
    func didStartSearching() {
        feedType.reloadData()
        selectFirstFeedType()
    }
    
    func didFinishSearching() {
        feedType.reloadData()
        selectFirstFeedType()
    }
    
    func didUpdateMovies(_ movies: [Movie]) {
        updateFeed(withMovies: movies)
    }
}

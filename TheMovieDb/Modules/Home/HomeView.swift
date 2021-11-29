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
    
    private lazy var feedType: UICollectionView = {
        var flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collection
    }()
    
    private lazy var movieFeed: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collection
    }()
    
    lazy var loader = LoadingViewController()
    
    lazy private var searchController = UISearchController()
    
    enum Section: Int, CaseIterable {
        case all
    }
    
    let normalFeeds: [FeedTypes] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
    
    let searchFeeds: [FeedTypes] = [.search, .keyword]
    
    private var firstLoaded = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstLoaded {
            selectFirstFeedType()
            firstLoaded = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.getMoviesIfNeeded(search: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
        configureSearch()
        configureFeedCollection()
        configureTypesCollection()
        activateConstraints()
    }
    
    func setupUI() {
        title = "home.navigation.title".localized
        view.addSubview(movieFeed)
        view.addSubview(feedType)
    }
    
    func activateConstraints() {
        movieFeed.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieFeed.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieFeed.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            movieFeed.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            movieFeed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        feedType.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedType.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedType.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            feedType.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            feedType.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureTypesCollection() {
        feedType.register(FeedTypeCell.self, forCellWithReuseIdentifier: FeedTypeCell.cellIdentifier)
        feedType.dataSource = self
        feedType.delegate = self
        feedType.backgroundColor = .clear
    }
    
    func configureFeedCollection() {
        movieFeed.register(MoviesFeedCell.self, forCellWithReuseIdentifier: MoviesFeedCell.cellIdentifier)
        movieFeed.collectionViewLayout = makeCollectionViewLayout()
        movieFeed.dataSource = self
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
        switch collectionView {
        case movieFeed:
            return presenter.getMoviesCount()
        case feedType:
            if presenter.isSearching {
                return searchFeeds.count
            } else {
                return normalFeeds.count
            }
        default:
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch collectionView {
        case movieFeed:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MoviesFeedCell.cellIdentifier,
                for: indexPath
            ) as? MoviesFeedCell
            cell?.updateUI(withMovie: presenter.getMovie(forPosition: indexPath.row))
            return cell ?? UICollectionViewCell()
        case feedType:
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
        default:
            return UICollectionViewCell()
        }
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
            let selectedMovie = presenter.getMovie(forPosition: indexPath.row)
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
        movieFeed.reloadData()
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

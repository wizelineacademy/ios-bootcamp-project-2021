//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

enum FeedTypes: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
}

private extension FeedTypes {
    var feedTitle: String {
        switch self {
        case .trending: return "Trending"
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Upcoming"
        }
    }
}

final class HomeView: UIViewController {
    
    @IBOutlet weak var feedType: UICollectionView!
    
    @IBOutlet weak var movieFeed: UICollectionView!
    
    lazy var loader = LoadingViewController()
    
    private lazy var moviesDataSource = makeDataSource()
    
    enum Section: Int, CaseIterable {
        case all
    }
    
    private var loadedPages = 0
    
    private var isLoading = false {
        didSet {
            if isLoading {
                add(loader)
            } else {
                loader.remove()
            }
        }
    }
    
    private var movies = [Movie]()
    
    private let movieAPI = MovieDBAPI()
    
    private var firstLoaded = true
    
    private var currentFeed: FeedTypes = .trending {
        didSet {
            movies.removeAll()
            loadedPages = 0
            getMoviesIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFeedCollection()
        configureTypesCollection()
        getMoviesIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if firstLoaded {
            feedType.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
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
    
    func getMoviesIfNeeded() {
        guard !isLoading else {
            return
        }
        isLoading = true
        let request = MovieDBAPI.GetMovies(
            on: currentFeed,
            queries: [.page: String(loadedPages + 1)]
        )
        movieAPI.execute(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.loadedPages = response.page
                self?.movies.append(contentsOf: response.results)
                self?.updateFeed()
            case .failure(let error):
                print(error)
            }
            self?.isLoading = false
        }
    }
}

extension HomeView: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return FeedTypes.allCases.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FeedTypeCell.cellIdentifier,
            for: indexPath
        ) as? FeedTypeCell
        cell?.updateUI(withFeedTitle: FeedTypes.allCases[indexPath.row].feedTitle)
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
                getMoviesIfNeeded()
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
            break
        case feedType:
            currentFeed = FeedTypes.allCases[indexPath.row]
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
    
    func updateFeed() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(movies)
        moviesDataSource.apply(snapshot, animatingDifferences: true)
    }
}

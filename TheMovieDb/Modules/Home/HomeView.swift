//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class HomeView: UIViewController {
    
    @IBOutlet weak var movieFeed: UICollectionView!
    
    private lazy var moviesDataSource = makeDataSource()
    
    enum Section: Int, CaseIterable {
        case all
    }
    
    var loadedPages = 0
    
    var isLoading = false
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFeedCollection()
        getMoviesIfNeeded()
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
        MovieDBAPI().execute(MovieDBAPI.GetMovies(on: .trending, extraQueryParams: ["page": String(loadedPages + 1)])) { [weak self] result in
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

extension HomeView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row == collectionView.numberOfItems(inSection: 0) - 1 {
            getMoviesIfNeeded()
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

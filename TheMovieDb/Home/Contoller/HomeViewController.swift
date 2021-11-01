//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    // MARK: - Properties
    private var topMovies = [Movie]()
    private var playingNowMovies = [Movie]()
    private var upComingMovies = [Movie]()
    private var trendingMovies = [Movie]()
    private var popularMovies = [Movie]()
    private var apiManager = APIManager()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewController.configureCollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUICollection()
        loadDataAPI()
    }
    // MARK: - API
    private func loadDataAPI() {
        apiManager.fetch { movies in
            self.playingNowMovies = movies["playingNowMovies"] ?? [Movie]()
            self.upComingMovies = movies["upComingMovies"] ?? [Movie]()
            self.trendingMovies = movies["trendingMovies"] ?? [Movie]()
            self.popularMovies = movies["popularMovies"] ?? [Movie]()
            self.topMovies = movies["topMovies"] ?? [Movie]()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    private func configureUICollection() {
        collectionView.register(HightSectionCell.self, forCellWithReuseIdentifier: HightSectionCell.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        collectionView.register(TopRatedSectionCell.self, forCellWithReuseIdentifier: TopRatedSectionCell.reuseIdentifier)
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: categoryHomeHeaderId, withReuseIdentifier: HomeHeader.reuseIdentifier)
    }
    
    private func getCurrentMovie(indexPath: IndexPath) -> Movie {
        let section = GroupSections(rawValue: indexPath.section) ?? .trending
        var movie: Movie
        switch section {
        case .popular:
            movie = popularMovies[indexPath.row]
        case .trending:
            movie = trendingMovies[indexPath.row]
        case .playingNow:
            movie = playingNowMovies[indexPath.row]
        case .topRated:
            movie = topMovies[indexPath.row]
        case .upcoming:
            movie = upComingMovies[indexPath.row]
        }
        return movie
    }
    
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .black
    }
    // MARK: - Actions
    
}

// MARK: - UIControllerViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = GroupSections(rawValue: section) ?? .trending
        
        switch section {
        case .popular:
            return popularMovies.count
        case .trending:
            return trendingMovies.count
        case .playingNow:
            return playingNowMovies.count
        case .topRated:
            return topMovies.count
        case .upcoming:
            return upComingMovies.count
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = GroupSections(rawValue: indexPath.section) ?? .topRated
        let movie = getCurrentMovie(indexPath: indexPath)
        
        switch section {
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightSectionCell.reuseIdentifier, for: indexPath) as? HightSectionCell else {
                return HightSectionCell()
            }
            
            cell.withMovie(with: movie)
            return cell
        case .topRated:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedSectionCell.reuseIdentifier, for: indexPath) as? TopRatedSectionCell else {
                return TopRatedSectionCell()
            }
            cell.numberTop = indexPath.row
            cell.withMovie(with: movie)
            return cell
            
        case .upcoming, .trending, .playingNow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell else {
                return DefaultSectionCell()
            }
            cell.withMovie(with: movie)
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeader.reuseIdentifier, for: indexPath) as? HomeHeader else {
            return HomeHeader()
        }
        
        let section = GroupSections(rawValue: indexPath.section)
        if section != .popular {
            header.nameHeader = section
        }
        return header
    }
}

// MARK: - UICollectionViewControllerDelegate
extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = getCurrentMovie(indexPath: indexPath)
        let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

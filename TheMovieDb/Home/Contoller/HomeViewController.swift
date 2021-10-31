//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

let categoryHomeHeaderId = "categoryHomeHeaderId"
final class HomeViewController: UICollectionViewController {
    // MARK: - Properties
    private var movies = [Movie]()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(collectionViewLayout: HomeViewController.configureCollectionViewLayout())
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
        movies = DataManager().fetch()
    }
    
    // MARK: - Helpers
    private func configureUICollection() {
        // register cells
        collectionView.register(HightSectionCell.self, forCellWithReuseIdentifier: HightSectionCell.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        collectionView.register(TopSectionCell.self, forCellWithReuseIdentifier: TopSectionCell.reuseIdentifier)
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: categoryHomeHeaderId, withReuseIdentifier: HomeHeader.reuseIdentifier)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .systemBackground
    }
    // MARK: - Actions
    
}

// MARK: - UIControllerViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = GroupSections(rawValue: section)
        
        switch section {
        case .popular:
            return movies.count
        case .trending:
            return movies.count
        case .playingNow:
            return movies.count
        case .topRated:
            return movies.count
        case .upcoming:
            return movies.count
        case .none:
            return 0
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = GroupSections(rawValue: indexPath.section)
        let movie = movies[indexPath.row]
        switch section {
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightSectionCell.reuseIdentifier, for: indexPath) as? HightSectionCell else {
                return HightSectionCell()
            }
            
            cell.withMovie(with: movie)
            return cell
        case .topRated:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSectionCell.reuseIdentifier, for: indexPath) as? TopSectionCell else {
                return TopSectionCell()
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
        case .none:
            let cell = DefaultSectionCell()
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

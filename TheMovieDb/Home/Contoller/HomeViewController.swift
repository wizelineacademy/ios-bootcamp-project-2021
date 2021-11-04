//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    // MARK: - Properties
    private let group = DispatchGroup()
    
    var movies: [MovieGroupSections: [Movie]] = [:]
    
    // MARK: - Life Cycle
    
    init(with layout: UICollectionViewCompositionalLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUICollection()
        fetchDataAPI()
    }
    // MARK: - API
    private func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func fetchDataAPI() {
        fetchData(typeMovieSection: .popular)
        fetchData(typeMovieSection: .upcoming)
        fetchData(typeMovieSection: .topRated)
        fetchData(typeMovieSection: .playingNow)
        fetchData(typeMovieSection: .trending)
        group.notify(queue: .main) {
            self.reloadCollectionView()
        }
    }
    
    private func fetchData(typeMovieSection: MovieGroupSections) {
        group.enter()
        MovieAPI.shared.fetchData(endPoint: typeMovieSection.path, completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies[typeMovieSection] = res.movies
            }
            self.group.leave()
        })
    }
    
    // MARK: - Helpers
    private func configureUICollection() {
        collectionView.register(HightSectionCell.self, forCellWithReuseIdentifier: HightSectionCell.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        collectionView.register(TopRatedSectionCell.self, forCellWithReuseIdentifier: TopRatedSectionCell.reuseIdentifier)
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: categoryHomeHeaderId, withReuseIdentifier: HomeHeader.reuseIdentifier)
    }
    
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .black
    }
    
}

// MARK: - UIControllerViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieGroupSections(rawValue: section) ?? .trending
        return movies[section]?.count ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MovieGroupSections.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = MovieGroupSections(rawValue: indexPath.section) ?? .topRated
        guard let movies = movies[section] else { return DefaultSectionCell() }
        let movie =  movies[indexPath.row]
        
        switch section {
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightSectionCell.reuseIdentifier, for: indexPath) as? HightSectionCell else {
                return HightSectionCell()
            }
            var viewModel = MovieViewModel(movie: movie)
            viewModel.isHighSection = true
            cell.viewModel = viewModel
            return cell
        case .topRated:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedSectionCell.reuseIdentifier, for: indexPath) as? TopRatedSectionCell else {
                return TopRatedSectionCell()
            }
          
            var viewModel = MovieViewModel(movie: movie)
            viewModel.numerTop = indexPath.row
            cell.viewModel = viewModel
            return cell
            
        case .upcoming, .trending, .playingNow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell else {
                return DefaultSectionCell()
            }
            let viewModel = MovieViewModel(movie: movie)
            cell.viewModel = viewModel
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeader.reuseIdentifier, for: indexPath) as? HomeHeader else {
            return HomeHeader()
        }
        
        let section = MovieGroupSections(rawValue: indexPath.section)
        if section != .popular {
            header.nameHeader = section
        }
        return header
    }
}

// MARK: - UICollectionViewControllerDelegate
extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = MovieGroupSections(rawValue: indexPath.section) ?? .topRated
        guard let movies = movies[section] else { return }
        let movie = movies[indexPath.row]
        let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension HomeViewController {
     func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var section: NSCollectionLayoutSection?
            
            switch sectionIndex {
            case 0:
                section = HomeViewController.getHightLayoutSection()
            case 3:
                section = HomeViewController.getTopRatedLayoutSection()
            default:
                section = HomeViewController.getDefaultLayoutSection()
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

    static func getHightLayoutSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let seccion = NSCollectionLayoutSection(group: group)
        seccion.orthogonalScrollingBehavior = .paging
        seccion.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return seccion
        
    }

    static func getDefaultLayoutSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
        item.contentInsets.trailing = 16
        item.contentInsets.bottom = 16
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: categoryHomeHeaderId, alignment: .topLeading)
        ]
        
        return section

    }

    static func getTopRatedLayoutSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: categoryHomeHeaderId, alignment: .topLeading)
        ]
        
        return section

    }
}

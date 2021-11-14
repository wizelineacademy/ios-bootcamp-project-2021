//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Properties
    private let group = DispatchGroup()
    private var collectionView: UICollectionView!
    let categoryHomeHeaderId = "categoryHomeHeaderId"
    
    var movies: [MovieGroupSections: [Movie]] = [:]
    
    // MARK: - Life Cycle
    
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
        let layout = configureCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        collectionView.register(HightSectionCell.self, forCellWithReuseIdentifier: HightSectionCell.reusableIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reusableIdentifier)
        collectionView.register(TopRatedSectionCell.self, forCellWithReuseIdentifier: TopRatedSectionCell.reusableIdentifier)
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: categoryHomeHeaderId, withReuseIdentifier: HomeHeader.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .systemBackground
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieGroupSections(rawValue: section) ?? .trending
        return movies[section]?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MovieGroupSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = MovieGroupSections(rawValue: indexPath.section) ?? .topRated
        guard let movies = movies[section] else { return DefaultSectionCell() }
        let movie =  movies[indexPath.row]
        
        switch section {
        case .popular:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightSectionCell.reusableIdentifier, for: indexPath) as? HightSectionCell else {
                return HightSectionCell()
            }
            var viewModel = MovieViewModel(movie: movie)
            viewModel.isHighSection = true
            cell.viewModel = viewModel
            return cell
        case .topRated:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedSectionCell.reusableIdentifier, for: indexPath) as? TopRatedSectionCell else {
                return TopRatedSectionCell()
            }
          
            var viewModel = MovieViewModel(movie: movie)
            viewModel.numerTop = indexPath.row
            cell.viewModel = viewModel
            return cell
            
        case .upcoming, .trending, .playingNow:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reusableIdentifier, for: indexPath) as? DefaultSectionCell else {
                return DefaultSectionCell()
            }
            let viewModel = MovieViewModel(movie: movie)
            cell.viewModel = viewModel
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeader.reusableIdentifier, for: indexPath) as? HomeHeader else {
            return HomeHeader()
        }
        
        let section = MovieGroupSections(rawValue: indexPath.section)
        if section != .popular {
            header.nameHeader = section
        }
        return header
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = MovieGroupSections(rawValue: indexPath.section) ?? .topRated
        guard let movies = movies[section] else { return }
        let movie = movies[indexPath.row]
        
        let controller = MovieDetailWireFrame.createMovieDetailModule(with: movie)
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension HomeViewController {
    private func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionGroup = MovieGroupSections(rawValue: sectionIndex)
            var section: NSCollectionLayoutSection?
            
            switch sectionGroup {
            case .popular:
                section = self.getHightLayoutSection()
            case .topRated:
                section = self.getTopRatedLayoutSection()
            default:
                section = self.getDefaultLayoutSection()
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

    private func getHightLayoutSection() -> NSCollectionLayoutSection {
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

    private  func getDefaultLayoutSection() -> NSCollectionLayoutSection {
        
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

    private func getTopRatedLayoutSection() -> NSCollectionLayoutSection {
        
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

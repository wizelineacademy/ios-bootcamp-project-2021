//
//  HomeView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class HomeView: UIViewController, DisplayError, DisplaySpinner {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    private let group = DispatchGroup()
    private var collectionView: UICollectionView!
    let categoryHomeHeaderId = "categoryHomeHeaderId"
    
    var movies: [MovieGroupSections: [Movie]] = [:]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
        configureUICollection()
        Log.viewDidload.description
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
        navigationItem.title = InterfaceConst.moviesTitle
        view.backgroundColor = .systemBackground
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieGroupSections(rawValue: section) ?? .trending
        return movies[section]?.count ?? InterfaceConst.defaultValueItemsCell
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
        
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeHeader.reusableIdentifier,
            for: indexPath
        ) as? HomeHeader else {
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
extension HomeView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = MovieGroupSections(rawValue: indexPath.section) ?? .topRated
        guard let movies = movies[section] else { return }
        let movie = movies[indexPath.row]
        
        presenter?.showMovie(movie)
        
    }
    
}

private extension HomeView {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
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
    
    func getHightLayoutSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
            heightDimension: .fractionalWidth(InterfaceConst.fractionHightLayoutSection)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: InterfaceConst.initZeroValue, leading: InterfaceConst.initZeroValue,
            bottom: InterfaceConst.initZeroValue, trailing: InterfaceConst.initZeroValue
        )
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
            heightDimension: .fractionalWidth(InterfaceConst.fractionHightLayoutSection)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = NSDirectionalEdgeInsets(
            top: InterfaceConst.initZeroValue,
            leading: InterfaceConst.initZeroValue,
            bottom: InterfaceConst.initZeroValue,
            trailing: InterfaceConst.initZeroValue
        )
        
        return section
        
    }
    
    func getDefaultLayoutSection() -> NSCollectionLayoutSection {
        var sizeHeight: NSCollectionLayoutDimension = .fractionalHeight(InterfaceConst.fractionDefaultHeightSection)
        var sizeWidth: NSCollectionLayoutDimension = .fractionalWidth(InterfaceConst.fractionDefaultWidthSection)
        if UIDevice.current.userInterfaceIdiom == .pad {
            sizeHeight = .fractionalHeight(InterfaceConst.fractionDefaultHeightPadSection)
            sizeWidth = .fractionalWidth(InterfaceConst.fractionDefaultWidthPadSection)
        }
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: sizeWidth,
            heightDimension: .fractionalHeight(InterfaceConst.fractionWidthDefaultValueSection)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.trailing = InterfaceConst.paddingDefaultLayout
        item.contentInsets.bottom = InterfaceConst.paddingDefaultLayout
        
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
            heightDimension: sizeHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = InterfaceConst.paddingDefaultLayout
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [
            .init(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
                    heightDimension: .absolute(InterfaceConst.headerHeight)
                ),
                elementKind: categoryHomeHeaderId, alignment: .topLeading
            )
        ]
        
        return section
        
    }
    
    func getTopRatedLayoutSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(InterfaceConst.fractionTopRatedWidthSection),
            heightDimension: .fractionalHeight(InterfaceConst.fractionTopRatedHeightSection)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: InterfaceConst.initZeroValue,
            leading: InterfaceConst.initZeroValue,
            bottom: InterfaceConst.initZeroValue,
            trailing: InterfaceConst.initZeroValue
        )
        
        var sizeHeight: NSCollectionLayoutDimension = .fractionalHeight(InterfaceConst.fractionTopRatedHeightDimensionSection)
        if UIDevice.current.userInterfaceIdiom == .pad {
            sizeHeight = .fractionalHeight(InterfaceConst.fractionTopRatedHeightDimensionPadSection)
        }
        // group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
            heightDimension: sizeHeight
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: InterfaceConst.initZeroValue,
            leading: InterfaceConst.paddingDefaultLayout,
            bottom: InterfaceConst.initZeroValue,
            trailing: InterfaceConst.initZeroValue
        )
        
        section.boundarySupplementaryItems = [
            .init(
                layoutSize:
                        .init(
                            widthDimension: .fractionalWidth(InterfaceConst.fractionWidthDefaultValueSection),
                            heightDimension: .absolute(InterfaceConst.headerHeight)
                        ),
                elementKind: categoryHomeHeaderId, alignment: .topLeading
            )
        ]
        
        return section
        
    }
}

extension HomeView: HomeViewProtocol {
    func hideSpinner() {
        removeSpinner()
    }
    
    func showSpinner() {
        displaySpinner()
    }
    
    func showErrorMessage(withMessage: String) {
        self.viewDisplayError(with: withMessage)
    }
    
    func showMovies(_ movies: [MovieGroupSections: [Movie]]) {
        self.movies = movies
        reloadCollectionView()
    }
    
}

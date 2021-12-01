//
//  MovieDetailView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class MovieDetailView: UICollectionViewController, DisplayError {
    
    // MARK: Properties
    var presenter: MovieDetailPresenterProtocol?
    public var viewModel: MovieDetailViewModel?
    var movies: [MovieDetailSections: [Movie]] = [:]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
        
    }
    
    init(layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        layout.sectionInset = UIEdgeInsets(
            top: InterfaceConst.initZeroValue,
            left: InterfaceConst.paddingDefault,
            bottom: InterfaceConst.initZeroValue,
            right: InterfaceConst.paddingDefault
        )
        layout.itemSize = CGSize(width: InterfaceConst.widthItemCellMovieDetail, height: InterfaceConst.heightItemCellMovieDetail)
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.reuseIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reusableIdentifier)
        
        guard let viewModel = viewModel else { return }
        navigationItem.title = viewModel.title
    }
    
    private func reloadCollectionView() {
        collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieDetailView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieDetailSections(rawValue: section) ?? .similar
        guard let movies = movies[section] else { return InterfaceConst.defaultValueItemsCell }
        return movies.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MovieDetailSections.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = MovieDetailSections(rawValue: indexPath.section) ?? .similar
        guard let movies = movies[section] else { return DefaultSectionCell() }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reusableIdentifier, for: indexPath) as? DefaultSectionCell else {
            return DefaultSectionCell()
        }
        
        let movie =   movies[indexPath.row]
        let viewModel = MovieViewModel(movie: movie)
        cell.viewModel = viewModel
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let groupName = MovieDetailSections(rawValue: indexPath.section)
        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeaderView.reuseIdentifier, for: indexPath) as? DetailHeaderView else {
                return DetailHeaderView()
            }
            header.viewModel = viewModel
            header.delegate = self
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.reuseIdentifier, for: indexPath) as? DetailHeader else {
                return DetailHeader()
            }
            header.nameHeader = groupName
            return header
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = MovieDetailSections(rawValue: section) ?? .similar
        switch section {
        case .recommendations:
            let frame = CGRect(x: InterfaceConst.initZeroValue, y: InterfaceConst.initZeroValue, width: view.frame.width, height: section.sizeCell)
            let estimatedSizeCell = DetailHeaderView(frame: frame)
            estimatedSizeCell.viewModel = viewModel
            estimatedSizeCell.layoutIfNeeded()
            let targetSize = CGSize(width: view.frame.width, height: section.sizeCell)
            let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
            return .init(width: view.frame.width, height: estimatedSize.height)
        case .similar:
            return CGSize(width: view.frame.height, height: section.sizeCell)
        }
        
    }
}

// MARK: - DetailHeaderViewDelegate
extension MovieDetailView: DetailHeaderViewDelegate {
    func openCasts(_ detailHeaderView: DetailHeaderView, with movie: Movie) {
        presenter?.showCast(movie)
    }
    
    func openReviews(_ detailHeaderView: DetailHeaderView, with movie: Movie) {
        presenter?.showReviews(movie)
    }
    
}

// MARK: - UICollectionViewControllerDelegate
extension MovieDetailView {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = MovieDetailSections(rawValue: indexPath.section) ?? .similar
        guard let movies = movies[section] else { return }
        let movie =   movies[indexPath.row]
        presenter?.showMovie(movie)
    }
    
}

extension MovieDetailView: MovieDetailViewProtocol {
    func showErrorMessage(withMessage: String) {
        self.viewDisplayError(with: withMessage)
    }
    
    func setMovie(_ movie: Movie) {
        self.viewModel = MovieDetailViewModel(movie: movie)
    }
    
    func showRealatedMovies(_ relatedMovies: [MovieDetailSections: [Movie]]) {
        movies = relatedMovies
        self.reloadCollectionView()
    }
}

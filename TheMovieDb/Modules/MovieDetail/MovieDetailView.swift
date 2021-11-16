//
//  MovieDetailView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class MovieDetailView: UICollectionViewController {
    
    // MARK: Properties
    var presenter: MovieDetailPresenterProtocol?
    public var movie: Movie?
    var movies: [MovieDetailSections: [Movie]] = [:]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
        
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 100, height: 140)
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
        
        guard let movie = movie else { return }
        navigationItem.title = movie.title
    }
    
    private func reloadCollectionView() {
        
        self.collectionView.reloadData()
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension MovieDetailView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieDetailSections(rawValue: section) ?? .similar
        guard let movies = movies[section] else { return 0}
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
            header.movie = movie
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
        return CGSize(width: view.frame.height, height: section.sizeCell)
    }
}

// MARK: - DetailHeaderViewDelegate
extension MovieDetailView: DetailHeaderViewDelegate {
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
    func setMovie(_ movie: Movie) {
        self.movie = movie
    }
    
    func showRealatedMoviews(_ relatedMovies: [MovieDetailSections: [Movie]]) {
        movies = relatedMovies
        self.reloadCollectionView()
    }
}

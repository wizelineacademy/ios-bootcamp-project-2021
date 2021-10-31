//
//  DetailViewController.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    // MARK: - Properties
    public var movie: Movie
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(with movie: Movie) {
        self.movie = movie
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    private func configureUI() {
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.reuseIdentifier)
        navigationItem.title = "title moview here"
        navigationItem.title = movie.title
    }

    // MARK: - Actions
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController {

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeaderView.reuseIdentifier, for: indexPath) as? DetailHeaderView else {
            return DetailHeaderView()
        }
        header.movie = movie
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 500)
    }
}

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
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 120, height: 140)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    private func configureUI() {
        collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeaderView.reuseIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.reuseIdentifier)
        
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        
        navigationItem.title = movie.title
    }

    // MARK: - Actions
    
}

// MARK: - UICollectionViewDataSource
extension DetailViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = MovieSections(rawValue: section)
        
        switch section {
        case .recommendations:
            return 10
        case .similar:
            return 13
        case .none:
            return 0
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell else {
            return DefaultSectionCell()
        }

        return cell
        
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let groupName = MovieSections(rawValue: indexPath.section)
        if indexPath.section == 0 {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeaderView.reuseIdentifier, for: indexPath) as? DetailHeaderView else {
                return DetailHeaderView()
            }
            header.movie = movie
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
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let section = MovieSections(rawValue: section)
        switch section {
        case .recommendations:
            return CGSize(width: view.frame.height, height: 500)
        case .similar:
            return CGSize(width: view.frame.height, height: 50)
        case .none:
            return CGSize(width: view.frame.height, height: 0)
        }

    }
}

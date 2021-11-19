//
//  GenericMovieCollectionView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 16/11/21.
//

import UIKit

class GenericMovieCollectionView: UICollectionView {
    var arrMovies: [SectionMovie: [MovieViewModel]] = [:] {
        didSet {
            configureDataSource()
        }
    }
    
    public init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: compositionalLayout)
    
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .systemBackground
        self.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifer)
        self.register(
          HeaderCollectionView.self,
          forSupplementaryViewOfKind: "HeaderCollectionView.reuseIdentifier",
          withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var dataSourceMovie: UICollectionViewDiffableDataSource<SectionMovie, MovieViewModel> = {
        return UICollectionViewDiffableDataSource
        <SectionMovie, MovieViewModel>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, movieItem: MovieViewModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LargeCollectionViewCell.reuseIdentifer,
                for: indexPath) as? LargeCollectionViewCell else { fatalError("Could not create new cell") }
            cell.title = movieItem.title
            cell.portraitPhotoURL = movieItem.image
            return cell
        }
        
    }()
    
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = 0.33
        let groupFractionalHeight: Float = 0.30
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalHeight(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: "HeaderCollectionView.reuseIdentifier",
          alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .groupPaging
        
        return UICollectionViewCompositionalLayout(section: section)
    }()

    func configureDataSource() {
        
        dataSourceMovie.supplementaryViewProvider = { (
          collectionView: UICollectionView,
          kind: String,
          indexPath: IndexPath) -> UICollectionReusableView? in

          guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderCollectionView.reuseIdentifier,
            for: indexPath) as? HeaderCollectionView else { fatalError("Cannot create header view") }

          supplementaryView.label.text = SectionMovie.allCases[indexPath.section].rawValue
          return supplementaryView
        }
        let snapshot = snapshotForCurrentState()
        dataSourceMovie.apply(snapshot, animatingDifferences: false)
        
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<SectionMovie, MovieViewModel> {
        var snapshot = NSDiffableDataSourceSnapshot<SectionMovie, MovieViewModel>()
        for (key, value) in arrMovies {
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        return snapshot
    }
    
}



//
//  GenericMovieCollectionView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 16/11/21.
//
/*
import UIKit



class GenericMovieCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: compositionalLayout)

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifer)
        collectionView.register(
          HeaderCollectionView.self,
          forSupplementaryViewOfKind: "HeaderCollectionView.reuseIdentifier",
          withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.sendSubviewToBack(refreshControl)
        self = collectionView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var dataSourceMovie: UICollectionViewDiffableDataSource<T, Movie>! = nil
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

    func setUpCollectionView() {
       
    }

    func configureDataSource() {
        dataSourceMovie = UICollectionViewDiffableDataSource
        <SectionMovie, Movie>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, movieItem: Movie) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: LargeCollectionViewCell.reuseIdentifer,
                for: indexPath) as? LargeCollectionViewCell else { fatalError("Could not create new cell") }
            cell.title = movieItem.title
            cell.portraitPhotoURL = movieItem.posterPath
            return cell
        }
        
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
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<T, Movie> {
        var snapshot = NSDiffableDataSourceSnapshot<T, Movie>()
        for (key, value) in arrMovies {
            snapshot.appendSections([key])
            snapshot.appendItems(value)
        }
        return snapshot
    }
    
}
*/

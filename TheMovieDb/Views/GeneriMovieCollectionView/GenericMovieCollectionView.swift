//
//  GenericMovieCollectionView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 16/11/21.
//

import UIKit

protocol GenericMovieCollectionViewDelegate: AnyObject {
    func selectedCollectionItem<T>(movie: T)
}

class GenericMovieCollectionView<Section: Hashable>: UICollectionView, UICollectionViewDelegate {
   
    weak var delegateCollection: GenericMovieCollectionViewDelegate?
    var arrMovies: [Section: [AnyHashable]] = [:]
    var sections: [AnyHashable]? = [] 
    var movieSelected: MovieViewModel?
    
    public init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        self.collectionViewLayout = generateLayout()
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .systemBackground
        delegate = self
        self.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifer)
        self.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.reuseIdentifer)
        self.register(OverviewCollectionViewCell.self, forCellWithReuseIdentifier: OverviewCollectionViewCell.reuseIdentifier)
        self.register(
            HeaderCollectionView.self,
            forSupplementaryViewOfKind: "HeaderCollectionView.reuseIdentifier",
            withReuseIdentifier: HeaderCollectionView.reuseIdentifier)
        self.register(
            DetailHeaderCollectionView.self,
            forSupplementaryViewOfKind: "HeaderCollectionView.reuseIdentifier",
            withReuseIdentifier: DetailHeaderCollectionView.reuseIdentifier)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var dataSourceMovie: UICollectionViewDiffableDataSource<Section, AnyHashable> = {
        return UICollectionViewDiffableDataSource
        <Section, AnyHashable>(collectionView: self) {
            (collectionView: UICollectionView, indexPath: IndexPath, movieItem: AnyHashable) -> UICollectionViewCell? in
            
            if Section.self == SectionMovieDetail.self {
             
                let sectionLayoutKind = self.sections?[indexPath.section] as? SectionMovieDetail
                switch sectionLayoutKind {
                case .header:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: OverviewCollectionViewCell.reuseIdentifier,
                        for: indexPath) as? OverviewCollectionViewCell,
                          let movieItem = movieItem as? MovieViewModel
                    else { fatalError("Could not create new cell") }
                    cell.viewModelMovie = movieItem
                    return cell
                case .comment:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: ReviewCollectionViewCell.reuseIdentifer,
                        for: indexPath) as? ReviewCollectionViewCell,
                          let movieItem = movieItem as? ReviewViewModel
                    else { fatalError("Could not create new cell") }
                    
                    cell.viewModelReview = movieItem
                    return cell
                    
                case .similar, .reccommendattions:
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: LargeCollectionViewCell.reuseIdentifer,
                        for: indexPath) as? LargeCollectionViewCell,
                          let movieItem = movieItem as? MovieViewModel
                    else { fatalError("Could not create new cell") }
                    
                    cell.title = movieItem.title
                    cell.portraitPhotoURL = movieItem.image
                    return cell
                case .none:
                    return nil
                }
            } else {
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LargeCollectionViewCell.reuseIdentifer,
                    for: indexPath) as? LargeCollectionViewCell,
                      let movieItem = movieItem as? MovieViewModel
                else { fatalError("Could not create new cell") }
                
                cell.title = movieItem.title
                cell.portraitPhotoURL = movieItem.image
                return cell
            }
        }
        
    }()
    
    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
          
          if Section.self == SectionMovieDetail.self {
              
              let sectionLayoutKind =  self.sections?[sectionIndex] as? SectionMovieDetail
              switch sectionLayoutKind {
              case .header: return self.generateHeaderLayout()
              case .comment: return self.generateCommentLayout()
              default: return self.generateMovieLayout()
              
              }
          } else {
              return self.generateMovieLayout()
          }
      }
      return layout
    }
    
    func generateMovieLayout() -> NSCollectionLayoutSection {
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
    
      return section
    }
    
    func generateCommentLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalWidth(2/3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupFractionalWidth = 0.95
        let groupFractionalHeight: Float =  2/3
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
          heightDimension: .fractionalWidth(CGFloat(groupFractionalHeight)))
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
        
      return section
    }
    
    func generateHeaderLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(70))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionalWidth = 1
        let groupFractionalHeight: Float = 0.2
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(CGFloat(groupFractionalWidth)),
            heightDimension: .fractionalHeight(CGFloat(groupFractionalHeight)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.4))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: "HeaderCollectionView.reuseIdentifier",
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
      return section
    }
    
    func configureDataSource() {
        
        dataSourceMovie.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionView.reuseIdentifier,
                for: indexPath) as? HeaderCollectionView else { fatalError("Cannot create header view") }
            
            if Section.self == SectionMovie.self {
                let sectionLayoutKind =  self.sections?[indexPath.section] as? SectionMovie
                supplementaryView.label.text = sectionLayoutKind?.rawValue
                return supplementaryView
            } else {
                let sectionLayoutKind =  self.sections?[indexPath.section] as? SectionMovieDetail
                switch sectionLayoutKind {
                case .header:
                    guard let supplementaryView2 = collectionView.dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier: DetailHeaderCollectionView.reuseIdentifier,
                        for: indexPath) as? DetailHeaderCollectionView else { fatalError("Cannot create header view") }
                    supplementaryView2.viewModelMovie = self.movieSelected
                    return supplementaryView2
                default:
                    let sectionLayoutKind =  self.sections?[indexPath.section] as? SectionMovieDetail
                    supplementaryView.label.text = sectionLayoutKind?.rawValue
                    return supplementaryView
                }
            }
            
        }
        let snapshot = snapshotForCurrentState()
        dataSourceMovie.apply(snapshot, animatingDifferences: false)
        
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, AnyHashable> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        for (key, _) in arrMovies {
            snapshot.appendSections([key])
            snapshot.appendItems(arrMovies[key] ?? [], toSection: key)

        }
        print(snapshot)
        return snapshot
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSourceMovie.itemIdentifier(for: indexPath) as? MovieViewModel {
            delegateCollection?.selectedCollectionItem(movie: item)
        } else if let item = dataSourceMovie.itemIdentifier(for: indexPath) as? ReviewViewModel {
            delegateCollection?.selectedCollectionItem(movie: item)
        }
        
    }
}

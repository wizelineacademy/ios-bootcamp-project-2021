//
//  MovieDetailDataSource.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

enum MovieDetailCellsLayout: Int, CaseIterable {
    case header = 0
    case similar = 1
    case overview = 2
}

class MovieDetailDataSource: NSObject, UICollectionViewDataSource {
    
    var movie: Movie?
    var detailItems: [MovieDetailCellsLayout] = [.header, .similar]
    override init() {
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return detailItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let type = MovieDetailCellsLayout(rawValue: section)
        switch type {
        case .header:
            return 1
        case .overview:
            return 1
        case .similar:
            return 10
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let itemType = detailItems[indexPath.section]
        switch itemType {
        case .header:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifierToDeque, for: indexPath) as? HeaderCollectionViewCell, let movie = self.movie {
                cell.setInfoWith(movie: movie)
                return cell
            }
        case .overview:
            return UICollectionViewCell()
        case .similar:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifierToDeque, for: indexPath) as? MovieCollectionViewCell {
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
}

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
    
    var movie: MovieDetailProtocol?
    var similarMovies: MovieList?
    var detailItems: [MovieDetailCellsLayout] = [.header, .similar]
    override init() {
        super.init()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      //  let type = MovieDetailCellsLayout(rawValue: section)
        switch section {
        case 0:
            return 1
        case 1:
            return self.similarMovies?.results.count ?? 0
        case 2:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifierToDeque, for: indexPath) as? HeaderCollectionViewCell, let movie = self.movie {
                cell.setInfoWith(movie: movie)
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifierToDeque, for: indexPath) as? MovieCollectionViewCell {
                if let movie = self.similarMovies?.results[indexPath.row] {
                cell.setInfoWith(movie: movie)
                }
                return cell
            }
        case 2:
            return UICollectionViewCell()

        default:
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
}

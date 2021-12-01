//
//  MovieDetailDelegate.swift
//  TheMovieDb
//
//  Created by developer on 24/11/21.
//

import UIKit

class MovieDetailDelegate: NSObject, UICollectionViewDelegate {
    
    var movie: MovieDetailProtocol?
    var similarMovies: MovieList?
    var didSelectSimilarMovie: ((_ movie: MovieProtocol) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let movie = similarMovies?.results[indexPath.row] {
            didSelectSimilarMovie?(movie)
            }
        }
    }

}

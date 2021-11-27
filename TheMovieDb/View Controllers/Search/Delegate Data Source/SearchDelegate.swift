//
//  SearchDelegate.swift
//  TheMovieDb
//
//  Created by developer on 26/11/21.
//

import Foundation
import UIKit

class SearchDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectMovie: ((_ movie: MovieProtocol) -> Void)?
    var movieList: MovieList?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movieList?.results[indexPath.row] else { return }
        didSelectMovie?(movie)
    }
}

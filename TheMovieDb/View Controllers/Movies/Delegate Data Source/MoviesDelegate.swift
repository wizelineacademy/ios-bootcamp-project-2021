//
//  MoviesDelegate.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

class MoviesDelegate: NSObject, UICollectionViewDelegate {

    var feed = MoviesFeed(listsOfElements: [:])
    var didSelectMovie: ((_ movie: MovieProtocol) -> Void)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = Topic.allCases[indexPath.section]
        guard let list = feed.listsOfElements[topic] else { return }
        let movie = list.results[indexPath.row]
        didSelectMovie?(movie)        
        
    }
}

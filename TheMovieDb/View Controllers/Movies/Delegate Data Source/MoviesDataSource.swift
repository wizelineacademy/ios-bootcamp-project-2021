//
//  MoviesDataSource.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation
import UIKit

class MoviesDataSource: NSObject, UICollectionViewDataSource {
    
    var feed = MoviesFeed(listsOfElements: [:])
    var identifier: String = ""
    
    override init() {
        super.init()
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return feed.listsOfElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let topic = Topic.allCases[section]
        guard let list =  feed.listsOfElements[topic] else { return 0 }
        let count = list.results.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topic = Topic.allCases[indexPath.section]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell, let list = feed.listsOfElements[topic] else { return UICollectionViewCell() }
        let movie = list.results[indexPath.row]
        cell.setInfoWith(movie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let topic = Topic.allCases[indexPath.section]
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifierToDeque, for: indexPath) as? HeaderCollectionReusableView {
            header.setTopicTitle(topic: topic)
        return header
        }
        
        return UICollectionReusableView()
    }
}

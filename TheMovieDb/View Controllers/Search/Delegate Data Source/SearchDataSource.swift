//
//  SearchDataSource.swift
//  TheMovieDb
//
//  Created by developer on 25/11/21.
//

import UIKit

class SearchDataSource: NSObject, UICollectionViewDataSource {
    var identifier: String = ""
    var movieList: MovieList?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieList?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCollectionViewCell, let movie = movieList?.results[indexPath.row] else { return UICollectionViewCell() }
        cell.setInfoWith(movie: movie)
        return cell
    }
}

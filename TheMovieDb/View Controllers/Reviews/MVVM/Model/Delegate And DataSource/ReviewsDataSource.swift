//
//  ReviewsDataSource.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import UIKit

class ReviewsDataSource: NSObject, UICollectionViewDataSource {
    
    var reviewsViewModelList: ReviewsViewModelList?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewsViewModelList?.results.count ?? 0 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifierToDeque, for: indexPath) as? ReviewCollectionViewCell, let viewModel = reviewsViewModelList?.results[indexPath.row] {
            cell.setInfoWith(viewModel: viewModel)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
  
}

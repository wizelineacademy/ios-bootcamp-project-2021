//
//  DetailReviewsFlowLayout.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 09/11/21.
//

import Foundation
import UIKit

final class DetailReviewsFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        minimumLineSpacing = 32
        let collectionWidth = collectionView?.bounds.width ?? 0
        let cellWidth = collectionWidth - 32
        let cellHeight = collectionView?.bounds.height ?? 0
        itemSize = CGSize(width: cellWidth, height: cellHeight)
    }
}

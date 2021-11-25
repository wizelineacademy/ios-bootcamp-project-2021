//
//  DetailRecommendationsFlowLayout.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 13/11/21.
//

import Foundation
import UIKit

final class DetailRecommendationsFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let height: CGFloat = collectionView?.bounds.height ?? 0
        let width: CGFloat = height * (9/16)
        minimumLineSpacing = 8
        itemSize = CGSize(width: width, height: height)
    }
}

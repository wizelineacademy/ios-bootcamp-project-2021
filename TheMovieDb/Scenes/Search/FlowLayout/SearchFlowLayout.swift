//
//  SearchFlowLayout.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import Foundation
import UIKit

final class SearchFlowLayout: UICollectionViewFlowLayout {
    
    private let verticalContentInset: CGFloat = 8
    
    override func prepare() {
        scrollDirection = .vertical
        let safeAreaLeft = collectionView?.safeAreaInsets.left ?? 0
        let safeAreaRight = collectionView?.safeAreaInsets.right ?? 0
        let collectionWidth = collectionView?.bounds.width ?? 0
        sectionInset = UIEdgeInsets(top: 0,
                                    left: verticalContentInset + safeAreaLeft,
                                    bottom: 0,
                                    right: verticalContentInset + safeAreaRight)
        let cellWidth: CGFloat = collectionWidth - safeAreaLeft - safeAreaRight
        itemSize = CGSize(width: cellWidth - (verticalContentInset * 2),
                          height: 64)
    }
}

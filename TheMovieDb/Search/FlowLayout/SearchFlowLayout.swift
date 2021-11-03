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
        sectionInset = UIEdgeInsets(top: 0,
                                    left: verticalContentInset,
                                    bottom: 0,
                                    right: verticalContentInset)
        let cellWidth: CGFloat = collectionView?.bounds.width ?? 0
        itemSize = CGSize(width: cellWidth - (verticalContentInset * 2),
                          height: 56)
    }
}

//
//  ColumnFlowLayout.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 03/11/21.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {

    private let preferedSize: CGSize = .init(width: 130, height: 230)
    private let preferedSpacing: CGFloat = 5

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        minimumInteritemSpacing = preferedSpacing

        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth / preferedSize.width)
        let cellWidth = floor(availableWidth / CGFloat(maxNumColumns))

        itemSize = CGSize(width: cellWidth, height: preferedSize.height)
        sectionInset = UIEdgeInsets(top: preferedSpacing * 2,
                                    left: preferedSpacing,
                                    bottom: preferedSpacing,
                                    right: preferedSpacing)
        sectionInsetReference = .fromSafeArea

    }
}

//
//  DetailFlowLayout.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 04/11/21.
//

import Foundation
import UIKit

protocol DetailFlowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
}

final class DetailFlowLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: DetailFlowLayoutDelegate?
    private let dataSource: DetailDataSource
    
    init(dataSource: DetailDataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        collectionView?.delegate = self
        scrollDirection = .vertical
        let safeAreaLeft = collectionView?.safeAreaInsets.left ?? 0
        let safeAreaRight = collectionView?.safeAreaInsets.right ?? 0
        let safeAreaBottom = collectionView?.safeAreaInsets.bottom ?? 0
        let collectionWidth = collectionView?.bounds.width ?? 0
        sectionInset = UIEdgeInsets(top: 0,
                                    left: safeAreaLeft,
                                    bottom: safeAreaBottom + 64,
                                    right: safeAreaRight)
        let cellWidth: CGFloat = collectionWidth - safeAreaLeft - safeAreaRight
        let headerHeight = cellWidth
        headerReferenceSize = CGSize(width: cellWidth, height: headerHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource.collectionView(collectionView, sizeForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

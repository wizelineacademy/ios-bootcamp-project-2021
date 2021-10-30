//
//  UICollectionViewControllerExtension.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

extension UICollectionViewController {
    static let categoryHomeHeaderId = "categoryHomeHeaderId"
   static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _ ) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                item.contentInsets.trailing = 2
                item.contentInsets.bottom = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let seccion = NSCollectionLayoutSection(group: group)
                
                seccion.orthogonalScrollingBehavior = .paging
                
                return seccion
                
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                section.orthogonalScrollingBehavior = .continuous
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: categoryHomeHeaderId, alignment: .topLeading)
                ]
                
                return section
            }
            
        }
    }
}

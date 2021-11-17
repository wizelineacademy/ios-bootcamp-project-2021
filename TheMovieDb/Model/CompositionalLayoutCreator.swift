//
//  CompositionalLayoutCreator.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import Foundation
import UIKit

struct CompotitionalLayoutCreator {
    static func createLayoutForMovies() -> UICollectionViewCompositionalLayout {
        
        let compositionalLayout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            item.contentInsets.trailing = 5
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1/4), heightDimension: .estimated(300)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets.bottom = 10
            section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: HeaderCollectionReusableView.identifierToDeque, alignment: .topLeading)]
            return section
            
        }
        return compositionalLayout
    }
    
    static func createLayoutForMovieDetail() -> UICollectionViewCompositionalLayout {
        
        let compositionalLayout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            let type = MovieDetailCellsLayout(rawValue: sectionNumber)
            print("type \(type)")
            switch sectionNumber {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(620)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
            
                return section
                
            case 1:
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                item.contentInsets.bottom = 2

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1 / 4), heightDimension: .estimated(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .paging

                return section
                
            
            
            case 2:
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1 / 4), heightDimension: .estimated(100)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            default:
                return nil
            }
    
        }
        
        return compositionalLayout
    }
}

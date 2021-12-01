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
    
    static func createLayoutForMoviesSearch() -> UICollectionViewCompositionalLayout {
        
        let compositionalLayout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1)))
            item.contentInsets.bottom = 1
            item.contentInsets.trailing = 1
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/3)), subitems: [item])
            group.contentInsets.bottom = 1
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            
            return section
            
        }
        return compositionalLayout
    }
    
    static func createLayoutForMovieReviews() -> UICollectionViewCompositionalLayout {
        
        let compositionalLayout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
            item.contentInsets.top = 5
            item.contentInsets.bottom = 5
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.interGroupSpacing = 10
            section.contentInsets.leading = 10
            section.contentInsets.trailing = 10

            return section
        }
        return compositionalLayout
    }
}

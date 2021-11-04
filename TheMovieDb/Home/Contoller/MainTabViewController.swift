//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

let categoryHomeHeaderId = "categoryHomeHeaderId"
final class MainTabViewController: UITabBarController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .red
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
        tabBar.tintColor = .label

    }
    
    private func configureViewControllers() {
        
        let layout = configureCollectionViewLayout()
        let home = templateNavigationController(unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, title: "Home", rootViewController: HomeViewController(with: layout))
        
        let search = templateNavigationController(unselectedImage: UIImage(systemName: "magnifyingglass")!, selectedImage: UIImage(systemName: "text.magnifyingglass")!, title: "Search", rootViewController: SearchViewController())
        
        viewControllers = [home, search]
    }
    
}

extension MainTabViewController {
     func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var section: NSCollectionLayoutSection?
            
            switch sectionIndex {
            case 0:
                section = self.getHightLayoutSection()
            case 3:
                section = self.getTopRatedLayoutSection()
            default:
                section = self.getDefaultLayoutSection()
            }
            return section
        }
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }

     func getHightLayoutSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let seccion = NSCollectionLayoutSection(group: group)
        seccion.orthogonalScrollingBehavior = .paging
        seccion.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return seccion
        
    }

     func getDefaultLayoutSection() -> NSCollectionLayoutSection {
        
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

     func getTopRatedLayoutSection() -> NSCollectionLayoutSection {
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
        
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(35)), elementKind: categoryHomeHeaderId, alignment: .topLeading)
        ]
        
        return section

    }

}

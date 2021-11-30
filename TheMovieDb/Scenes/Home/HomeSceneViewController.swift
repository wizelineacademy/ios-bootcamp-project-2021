//
//  HomeSceneViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

protocol HomeSceneViewControllerInput: AnyObject {
    func showCollectionView(sections: [HomeSections])
}

protocol HomeSceneViewControllerOutput: AnyObject {
    func getSections()
}

final class HomeSceneViewController: UICollectionViewController {
    
    var interactor: HomeSceneInteractorInput?
    var router: HomeSceneRoutingLogic?
    private var sections: [HomeSections] = []
    
    init() {
        let identifier = String(describing: HomeSceneViewController.self)
        super.init(nibName: identifier, bundle: Bundle.main)
        tabBarItem.title = "Home"
        tabBarItem.image = UIImage.home
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(HomeViewCell.self,
                                forCellWithReuseIdentifier: HomeViewCell.identifier)
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.collectionViewLayout = HomeCollectionFlowLayout()
        interactor?.getSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeViewCell = collectionView.reuse(identifier: HomeViewCell.identifier,
                                                      for: indexPath)
        cell.section = sections[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.row]
        router?.showListSection(section: section)
    }
}

extension HomeSceneViewController: HomeSceneViewControllerInput {
    
    func showCollectionView(sections: [HomeSections]) {
        self.sections = sections
        collectionView.reloadData()
    }
}

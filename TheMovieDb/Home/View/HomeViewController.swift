//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

final class HomeViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.collectionViewLayout = HomeCollectionFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else {
            return UICollectionViewCell()
        }
        cell.section = HomeSections.allCases[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeSections.allCases.count
    }
    
    
    @IBSegueAction func goToListSectionActionSegue(_ coder: NSCoder, sender: Any?) -> ListSectionViewController? {
        guard let cell = sender as? HomeViewCell,
              let section = cell.section else {
                  return nil
              }
        return ListSectionViewController(title: section.title,
                                         request: section.request, coder: coder)
    }
}


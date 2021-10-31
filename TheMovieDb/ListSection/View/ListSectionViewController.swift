//
//  ListSectionViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import UIKit

final class ListSectionViewController: UICollectionViewController {
    
    static let segueIdentifier: String = "go-to-list-section"
    var section: HomeSections?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = section?.title
        collectionView.refreshControl = refreshControl
        collectionView.collectionViewLayout = ListSectionFlowLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ListSectionCell.identifier,
                                     for: indexPath) as? ListSectionCell else {
                    return UICollectionViewCell()
                }
        cell.progress = indexPath.row + 1
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
}

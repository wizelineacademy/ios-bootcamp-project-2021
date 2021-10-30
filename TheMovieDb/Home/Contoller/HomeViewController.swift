//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

let categoryHomeHeaderId = "categoryHomeHeaderId"
final class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    init() {
        super.init(collectionViewLayout: HomeViewController.configureCollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUICollection()
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // MARK: - Helpers
    private func configureUICollection() {
        // register cells
        collectionView.register(HightSectionCell.self, forCellWithReuseIdentifier: HightSectionCell.reuseIdentifier)
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reuseIdentifier)
        collectionView.register(TopSectionCell.self, forCellWithReuseIdentifier: TopSectionCell.reuseIdentifier)
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: categoryHomeHeaderId, withReuseIdentifier: HomeHeader.reuseIdentifier)
    }
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .systemBackground
    }
    // MARK: - Actions
    
}

// MARK: - UIControllerViewDataSource
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        switch indexPath.section {
        case 0:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HightSectionCell.reuseIdentifier, for: indexPath) as? MovieCellProtocol ?? UICollectionViewCell()
        case 3:
            guard let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSectionCell.reuseIdentifier, for: indexPath) as? TopSectionCell else {
                return TopSectionCell()
            }
            cell.topNumber = indexPath.row
            return cell
        default:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reuseIdentifier, for: indexPath) as? DefaultSectionCell ?? UICollectionViewCell()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeHeader.reuseIdentifier, for: indexPath) as? HomeHeader else {
            return HomeHeader()
        }
        
        let section = GroupSections(rawValue: indexPath.section)
        if section != .popular {
            header.nameHeader = section
        }
           
        return header
    }
}

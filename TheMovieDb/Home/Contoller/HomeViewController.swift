//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class HomeViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let cellId = "homeId"
    private let homeHeaderId = "homeHeaderId"
    
    // MARK: - Life Cycle
    init() {
        super.init(collectionViewLayout: HomeViewController.createLayout())
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUICollection()
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: homeHeaderId, for: indexPath)
        
        return header
    }
    
    // MARK: - Helpers
    private func configureUICollection() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(HomeHeader.self, forSupplementaryViewOfKind: HomeViewController.categoryHomeHeaderId, withReuseIdentifier: homeHeaderId)
    }
    private func configureUI() {
        navigationItem.title = "Movies"
        view.backgroundColor = .systemBackground
    }
    // MARK: - Actions

}

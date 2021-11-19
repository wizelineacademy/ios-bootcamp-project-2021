//
//  ListView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import UIKit

class ListView: NSObject {
    
    lazy var collectionView: UICollectionView = {
        let layout = ColumnFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.alwaysBounceVertical = true
        collection.indicatorStyle = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    var viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init()
        self.viewLoad()
    }
    
    private func viewLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        
        viewModel.refresh()
    }
    
}

extension ListView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.cellIdentifier, for: indexPath) as? MovieCell else {
            preconditionFailure("Failed to load collection view cell")
        }
        
        cell.movieViewModel = viewModel.movie(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let movieViewModel = viewModel.movie(at: indexPath.row)
        return true
    }
}

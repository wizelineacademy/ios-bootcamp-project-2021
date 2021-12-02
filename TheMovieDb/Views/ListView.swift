//
//  ListView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import UIKit

protocol NavigationDelegate: AnyObject {
    func navigate(movieViewModel: MovieViewModel)
}

class ListView: NSObject {
    
    lazy var collectionView: UICollectionView = {
        let layout = ColumnFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.alwaysBounceVertical = true
        collection.indicatorStyle = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.cellIdentifier)
        return collection
    }()
    
    lazy var nothingFoundView: NothingFoundView = {
        let nothingFoundView = NothingFoundView(frame: .zero)
        nothingFoundView.translatesAutoresizingMaskIntoConstraints = false
        return nothingFoundView
    }()
    
    var viewModel: ListViewModel
    private weak var navigationDelegate: NavigationDelegate?
    
    init(viewModel: ListViewModel, navigationDelegate: NavigationDelegate? = nil) {
        self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        super.init()
        self.viewLoad()
    }
    
    private func viewLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.refresh()
    }
    
}

extension ListView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
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
        navigationDelegate?.navigate(movieViewModel: movieViewModel)
        return true
    }
}

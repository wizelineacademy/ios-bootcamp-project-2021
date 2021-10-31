//
//  DetailViewController.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    // MARK: - Properties
    //public var movies: Movie
    
    // MARK: - Life Cycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewController.configureCollectionViewLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

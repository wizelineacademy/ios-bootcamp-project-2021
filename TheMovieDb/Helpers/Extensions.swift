//
//  Extensions.swift
//  TheMovieDb
//
//  Created by developer on 01/11/21.
//

import Foundation
import UIKit

extension UICollectionView {
    func registerNibForCellWith(name: String) {
        self.register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
    
    func registerViewWith(name: String) {
        self.register(UINib(nibName: name, bundle: nil), forSupplementaryViewOfKind: name, withReuseIdentifier: name)
    }
    
    func setup(dataSource: UICollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    func setup(delegate: UICollectionViewDelegate) {
        self.delegate = delegate
    }
}

extension UIImage {
    static var moviePlaceholder = UIImage(named: "moviePlaceholder")
}

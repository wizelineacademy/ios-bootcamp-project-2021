//
//  CollectionView+Extension.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 13/11/21.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func reuse<T: UICollectionViewCell>(identifier: String,
                                        for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: identifier,
                                   for: indexPath) as! T
    }
    
    func reuse<T: UICollectionReusableView>(reusableType: String,
                                            identifier: String,
                                            for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: reusableType,
                                                withReuseIdentifier: identifier,
                                                for: indexPath) as! T
    }
}

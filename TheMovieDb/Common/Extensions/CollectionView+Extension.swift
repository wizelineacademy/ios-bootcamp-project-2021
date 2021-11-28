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
        if let cell = dequeueReusableCell(withReuseIdentifier: identifier,
                                          for: indexPath) as? T {
            return cell
        }
        fatalError("cell isn't valid")
    }
    
    func reuse<T: UICollectionReusableView>(reusableType: String,
                                            identifier: String,
                                            for indexPath: IndexPath) -> T {
        if let reusableView = dequeueReusableSupplementaryView(ofKind: reusableType,
                                                               withReuseIdentifier: identifier,
                                                               for: indexPath) as? T {
            return reusableView
        }
        fatalError("reusableView isn't valid")
    }
}

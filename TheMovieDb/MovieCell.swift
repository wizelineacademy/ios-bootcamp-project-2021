//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 05/11/21.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(frame: CGRect(x: 30, y: 30, width: self.bounds.width - 50, height: 20))
        guard let titleLabel = titleLabel else {
            return
        }
        titleLabel.textColor = UIColor.blue
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

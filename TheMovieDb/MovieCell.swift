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
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .blue
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // titleLabel.frame = CGRect(x: 30, y: 30, width: 200, height: 50)
        titleLabel.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}

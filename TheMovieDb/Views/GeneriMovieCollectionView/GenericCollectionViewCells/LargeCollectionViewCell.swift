//
//  LargeCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 10/11/21.
//

import UIKit

class LargeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "large-movie-cell-reuse-identifier"
    let titleLabel = UILabel()
    let portraitImageView = UIImageView()
    let contentContainer = UIView()
    
    var title: String? {
        didSet {
            configure()
        }
    }
    
    var portraitPhotoURL: String? {
        didSet {
            configure()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LargeCollectionViewCell {
    func configure() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(portraitImageView)
        contentView.addSubview(contentContainer)
        
        portraitImageView.translatesAutoresizingMaskIntoConstraints = false
        portraitImageView.loadImage(urlString: portraitPhotoURL ?? "")
        portraitImageView.layer.cornerRadius = 4
        portraitImageView.clipsToBounds = true
        contentContainer.addSubview(portraitImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        contentContainer.addSubview(titleLabel)
        
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            portraitImageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            portraitImageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            portraitImageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: portraitImageView.bottomAnchor, constant: spacing),
            titleLabel.leadingAnchor.constraint(equalTo: portraitImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: portraitImageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

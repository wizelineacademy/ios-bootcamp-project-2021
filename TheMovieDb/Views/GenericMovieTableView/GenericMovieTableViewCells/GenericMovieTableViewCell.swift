//
//  GenericMovieTableViewCell.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 17/11/21.
//

import UIKit

class GenericMovieTableViewCell: UITableViewCell {
    static let reuseIdentifier = "cellGenericMovieTableViewCell"
    var movie: MovieViewModel? {
        didSet {
            setupUI()
        }
    }
    lazy var vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        return vwContainer
    }()
    
    lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        return titleLabel
    }()
    
    lazy var countVoteLabel: UILabel = {
        let countVoteLabel = UILabel()
        countVoteLabel.translatesAutoresizingMaskIntoConstraints = false
        countVoteLabel.numberOfLines = 0
        countVoteLabel.adjustsFontForContentSizeCategory = true
        return countVoteLabel
    }()
    
    lazy var starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .yellow
        return starImage
    }()
    
    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.numberOfLines = 0
        commentLabel.adjustsFontForContentSizeCategory = true
        return commentLabel
    }()
    
    lazy var createtLabel: UILabel = {
        let createtLabel = UILabel()
        createtLabel.translatesAutoresizingMaskIntoConstraints = false
        createtLabel.numberOfLines = 0
        createtLabel.textAlignment = .right
        createtLabel.adjustsFontForContentSizeCategory = true
        return createtLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
}

extension GenericMovieTableViewCell {
    
    private func setupUI() {
        vwContainer.layer.cornerRadius = 4
        vwContainer.clipsToBounds = true
        self.addSubview(vwContainer)
               
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        //posterImage.kf.setImage(with: movie?.image)
        posterImage.layer.cornerRadius = 4
        posterImage.clipsToBounds = true
        vwContainer.addSubview(posterImage)
        
        titleLabel.text = movie?.title
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        vwContainer.addSubview(titleLabel)
        
        setUpConstraint()
        
    }
    
    private func setUpConstraint() {
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
        
            vwContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
            vwContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: spacing),
            vwContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing),
            vwContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing),
            
            posterImage.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: spacing),
            posterImage.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: spacing),
            posterImage.widthAnchor.constraint(equalTo: vwContainer.widthAnchor, multiplier: 0.3),
            posterImage.heightAnchor.constraint(equalTo: posterImage.widthAnchor, multiplier: 3/2),
            posterImage.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -spacing),
            
            titleLabel.centerYAnchor.constraint(equalTo: posterImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: spacing),
            titleLabel.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -spacing)
        ])
        
    }
}

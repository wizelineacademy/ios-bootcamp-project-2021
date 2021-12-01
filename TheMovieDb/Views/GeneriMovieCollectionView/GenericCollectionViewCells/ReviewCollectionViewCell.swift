//
//  ReviewCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 26/11/21.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifer = "review-movie-cell-reuse-identifier"
    var viewModelReview: ReviewViewModel? {
        didSet {
            setUpUI()
        }
    }
    
    lazy var vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        return vwContainer
    }()
    
    lazy var avatarImage: UIImageView = {
        let avatarImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    lazy var userLabel: UILabel = {
        let userLabel = UILabel()
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.numberOfLines = 0
        userLabel.adjustsFontForContentSizeCategory = true
        return userLabel
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewCollectionViewCell {
    func setUpUI() {
        vwContainer.layer.cornerRadius = 4
        vwContainer.clipsToBounds = true
        vwContainer.backgroundColor = .secondarySystemBackground
        self.addSubview(vwContainer)
       
        userLabel.text = viewModelReview?.author
        userLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        vwContainer.addSubview(userLabel)
        
        countVoteLabel.text = viewModelReview?.rating
        countVoteLabel.font = UIFont.preferredFont(forTextStyle: .body)
        vwContainer.addSubview(countVoteLabel)
        
        vwContainer.addSubview(starImage)
        
        createtLabel.text = viewModelReview?.created
        createtLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        vwContainer.addSubview(createtLabel)
        
        commentLabel.text = viewModelReview?.content
        commentLabel.font = UIFont.preferredFont(forTextStyle: .body)
        vwContainer.addSubview(commentLabel)
       
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            vwContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwContainer.topAnchor.constraint(equalTo: self.topAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            userLabel.topAnchor.constraint(equalTo: vwContainer.topAnchor, constant: spacing * 2),
            userLabel.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: spacing),
            userLabel.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -spacing),
            
            starImage.leadingAnchor.constraint(equalTo: userLabel.leadingAnchor),
            starImage.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: spacing),
            
            countVoteLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: spacing),
            countVoteLabel.trailingAnchor.constraint(greaterThanOrEqualTo: createtLabel.leadingAnchor, constant: spacing),
            countVoteLabel.centerYAnchor.constraint(equalTo: starImage.centerYAnchor),
            
            createtLabel.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -spacing),
            createtLabel.centerYAnchor.constraint(equalTo: countVoteLabel.centerYAnchor),
            
            commentLabel.topAnchor.constraint(equalTo: starImage.bottomAnchor, constant: spacing),
            commentLabel.leadingAnchor.constraint(equalTo: starImage.leadingAnchor),
            commentLabel.trailingAnchor.constraint(equalTo: createtLabel.trailingAnchor),
            commentLabel.bottomAnchor.constraint(equalTo: vwContainer.bottomAnchor, constant: -spacing)
            
        ])
    }
}

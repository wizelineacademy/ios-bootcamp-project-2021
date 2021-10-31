//
//  ReviewCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: ReviewCell.self)

    private let logoImageView = BackgroundImageView()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Rotten Tomatoes"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "The Martix is a great example of a movie that will live for ever or a very log time. The story and concept are out of this world. Keanu Reeves plays his role with utter brilliance, the cast was very well put together and the graphics are still to this day amazing. All in all one of the best movies of all time"
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        layer.cornerRadius = 10
        backgroundColor = .darkGray
        
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10)
        logoImageView.setWidth(frame.height - 20)
        logoImageView.layer.cornerRadius = 10
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: topAnchor, left: logoImageView.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10)
    
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: authorNameLabel.bottomAnchor, left: logoImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

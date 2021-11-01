//
//  ReviewCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class ReviewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: ReviewCell.self)

    private let logoImageView = BackgroundImageView()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Rotten Tomatoes"
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "The Martix is a great example of a movie that will live for ever or a very log time. The story and concept are out of this world. Keanu Reeves plays his role with utter brilliance, the cast was very well put together and the graphics are still to this day amazing. All in all one of the best movies of all times is a great example of a movie that will live for ever or a very log time. The story and concept are out of this world. Keanu Reeves plays his role with utter brilliance, the cast was very well put together and the graphics are still to this day amazing. All in all one of the best movies of all times"
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
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        descriptionLabel.setWidth((frame.width / 3) * 2)
        
        addSubview(logoImageView)
        logoImageView.anchor(left: leftAnchor, bottom: bottomAnchor, right: descriptionLabel.leftAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        logoImageView.setHeight(frame.width / 3)
        logoImageView.layer.cornerRadius = 10
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: topAnchor, left: leftAnchor, right: descriptionLabel.leftAnchor, paddingTop: 10, paddingLeft: 10)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

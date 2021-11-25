//
//  RatingViewCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 10/11/21.
//

import UIKit

final class RatingViewCell: UICollectionViewCell {
    
    static let identifier: String = "rating-view-cell"
    
    private lazy var userReviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .headline,
                                          compatibleWith: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .body,
                                          compatibleWith: nil)
        return label
    }()
    
    var review: ReviewModel? {
        didSet {
            userReviewLabel.text = review?.author
            contentLabel.text = review?.content
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension RatingViewCell {
    
    func setup() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 3
        addSubview(userReviewLabel)
        addSubview(contentLabel)
        setupUserReviewContraints()
        setupContentContraints()
    }
    
    func setupUserReviewContraints() {
        userReviewLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        userReviewLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        userReviewLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
    }
    
    func setupContentContraints() {
        contentLabel.topAnchor.constraint(equalTo: userReviewLabel.bottomAnchor, constant: 8).isActive = true
        contentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        contentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        let bottomConstraint = contentLabel.bottomAnchor
            .constraint(equalTo: bottomAnchor, constant: -16)
        bottomConstraint.priority = UILayoutPriority(250)
        bottomConstraint.isActive = true
    }
}

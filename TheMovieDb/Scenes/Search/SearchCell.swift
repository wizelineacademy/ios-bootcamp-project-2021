//
//  SearchCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 03/11/21.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    static let cellIdentifier: String = "search-cell-identifier"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingView: RatedView = {
        let rating = RatedView(frame: .zero, maxValue: 10.0, placeholderText: "--")
        rating.strokeWidth = 3.0
        rating.strokeColor = UIColor.ratingFilled
        rating.backStrokeColor = UIColor.ratingNotFilled
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    private lazy var divider: UIView = {
        let divider = UIView(frame: .zero)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        return divider
    }()
    
    var movie: MovieModel? {
        didSet {
            ratingView.value = movie?.voteAverage ?? 0
            titleLabel.text = movie?.title
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

private extension SearchCell {
    
    private func setup() {
        addSubview(titleLabel)
        addSubview(ratingView)
        addSubview(divider)
        addTitleLabelConstraints()
        addRatingViewConstraints()
        addDividerConstraints()
    }
    
    private func addTitleLabelConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: ratingView.leftAnchor, constant: -8).isActive = true
    }
    
    private func addRatingViewConstraints() {
        ratingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ratingView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    private func addDividerConstraints() {
        divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

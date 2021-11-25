//
//  DetailRatingCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 05/11/21.
//

import UIKit

final class DetailRatingCell: UICollectionViewCell {
    
    static let identifier: String = "detail-rating-cell"
    
    private lazy var stackContainer: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var ratingView: RatedView = {
        let view: RatedView = RatedView(frame: .zero, maxValue: 10, placeholderText: "TDB")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.strokeWidth = 8
        view.backStrokeColor = UIColor.ratingNotFilled
        view.fontType = UIFont.preferredFont(forTextStyle: .title2,
                                             compatibleWith: nil)
        view.strokeColor = UIColor.ratingFilled
        return view
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        return label
    }()
    
    private lazy var voteCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        return label
    }()
    
    var movie: MovieRatingModel? {
        didSet {
            ratingView.value = movie?.rating ?? 0
            popularityLabel.text = "Popularity: \(movie?.popularity ?? 0)"
            voteCountLabel.text = "Vote Count: \(movie?.voteCount ?? 0)"
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
    
    static func getCellSize(collectionView: UICollectionView?) -> CGSize {
        let rightInset: CGFloat = collectionView?.safeAreaInsets.right ?? 0.0
        let leftInset: CGFloat = collectionView?.safeAreaInsets.left ?? 0.0
        let safeInsets: CGFloat = rightInset + leftInset
        let width: CGFloat = collectionView?.bounds.width ?? 0
        return CGSize(width: width - safeInsets, height: 120)
    }
}

private extension DetailRatingCell {
    
    func setup() {
        addSubview(stackContainer)
        addSubview(ratingView)
        stackContainer.addArrangedSubview(popularityLabel)
        stackContainer.addArrangedSubview(voteCountLabel)
        setupStackView()
        setupRatingView()
    }
    
    func setupRatingView() {
        ratingView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ratingView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 72).isActive = true
    }
    
    func setupStackView() {
        stackContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        stackContainer.rightAnchor.constraint(equalTo: ratingView.leftAnchor, constant: -8).isActive = true
    }
}

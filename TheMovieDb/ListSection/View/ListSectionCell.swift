//
//  ListSectionCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import UIKit

final class ListSectionCell: UICollectionViewCell {
    static let identifier: String = "list-section-cell"
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        return view
    }()
    
    private lazy var poster: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var stackInfo: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        return label
    }()
    
    private lazy var movieDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .callout, compatibleWith: nil)
        return label
    }()
    
    private lazy var rating: RatedView = {
        let rating = RatedView()
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var progress: Int = 0 {
        didSet {
            rating.progress = progress
        }
    }
    
    func setup() {
        addSubview(divider)
        addSubview(poster)
        addSubview(stackInfo)
        addSubview(rating)
        stackInfo.addArrangedSubview(movieTitle)
        stackInfo.addArrangedSubview(movieDescription)
        setupDividerConstraints()
        setupPosterConstraints()
        setupStackCostraints()
        setupRatingCostraints()
    }
    
    func setupDividerConstraints() {
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupPosterConstraints() {
        poster.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        poster.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 96).isActive = true
        poster.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    func setupStackCostraints() {
        stackInfo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackInfo.rightAnchor.constraint(equalTo: rating.leftAnchor, constant: -16).isActive = true
        stackInfo.leftAnchor.constraint(equalTo: poster.rightAnchor, constant: 8).isActive = true
    }
    
    func setupRatingCostraints() {
        rating.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rating.widthAnchor.constraint(equalToConstant: 52).isActive = true
        rating.heightAnchor.constraint(equalToConstant: 52).isActive = true
        rating.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    }
}

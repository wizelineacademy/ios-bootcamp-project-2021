//
//  ReviewCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class ReviewCell: UICollectionViewCell, Reusable {

    // MARK: - Properties
    public var viewModel: ReviewViewModel? {
        didSet {
            configure()
        }
    }
    private let logoImageView = BackgroundImageView()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    private func configureUI() {
        layer.cornerRadius = 10
        backgroundColor = .systemGray5
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        descriptionLabel.setHeight((frame.height / 2))
        
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 10)
        logoImageView.setWidth((frame.height / 2) - 30)
        logoImageView.setHeight((frame.height / 2) - 30)
        
        logoImageView.layer.cornerRadius = 10
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: topAnchor, left: logoImageView.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10)
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        descriptionLabel.text = viewModel.content
        authorNameLabel.text = viewModel.author
        logoImageView.kf.setImage(with: viewModel.imageUrl)

    }
    
}

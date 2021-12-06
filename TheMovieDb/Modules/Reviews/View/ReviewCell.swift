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
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.headerFontSize)
        label.numberOfLines = InterfaceConst.initZeroNumberLineValue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.defaultFontSize)
        label.numberOfLines = InterfaceConst.initZeroNumberLineValue
        return label
    }()
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    private func configureUI() {
        layer.cornerRadius = InterfaceConst.defaultCornerRadius
        backgroundColor = .systemGray5
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: InterfaceConst.paddingDefault,
            paddingLeft: InterfaceConst.paddingDefault,
            paddingBottom: InterfaceConst.paddingDefault,
            paddingRight: InterfaceConst.paddingDefault
        )
        
        descriptionLabel.setHeight((frame.height / InterfaceConst.divideInto2))
        
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: InterfaceConst.paddingDefault, paddingLeft: InterfaceConst.paddingDefault)
        logoImageView.setWidth((frame.height / InterfaceConst.divideInto2) - InterfaceConst.reviewImageSizeMinus)
        logoImageView.setHeight((frame.height / InterfaceConst.divideInto2) - InterfaceConst.reviewImageSizeMinus)
        
        logoImageView.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        
        addSubview(authorNameLabel)
        authorNameLabel.anchor(top: topAnchor, left: logoImageView.rightAnchor, right: rightAnchor, paddingTop: InterfaceConst.paddingDefault, paddingLeft: InterfaceConst.paddingDefault)
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        descriptionLabel.text = viewModel.content
        authorNameLabel.text = viewModel.author
        logoImageView.setImageFromNetwork(withURL: viewModel.imageUrl)

    }
    
}

//
//  HomeViewCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import UIKit

final class HomeViewCell: UICollectionViewCell {
    
    static let identifier: String = "home-collection-cell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        title.textColor = UIColor.white
        return title
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel(frame: .zero)
        description.numberOfLines = 0
        description.font = UIFont.preferredFont(forTextStyle: .caption1, compatibleWith: nil)
        description.textColor = UIColor.white
        return description
    }()
    
    var section: HomeSections? {
        didSet {
            contentView.backgroundColor = section?.color
            let image = section?.image?.withRenderingMode(.alwaysTemplate)
            imageView.image = image
            imageView.tintColor = UIColor.white
            titleLabel.text = section?.title
            descriptionLabel.text = section?.description
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 8
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.layer.cornerRadius = 8
        setupUI()
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        stackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

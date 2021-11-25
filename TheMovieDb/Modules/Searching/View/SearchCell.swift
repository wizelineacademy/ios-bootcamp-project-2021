//
//  SearchCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 08/11/21.
//

import UIKit

final class SearchCell: UITableViewCell, Reusable {
    // MARK: - Properties
    public var viewModel: MovieViewModel? {
        didSet {
            configure()
        }
    }
    private let imageSearchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        addSubview(imageSearchImageView)
        imageSearchImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10)
        imageSearchImageView.setWidth(frame.height)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: imageSearchImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        imageSearchImageView.setImageFromNetwork(withURL: viewModel.imageUrl)
        titleLabel.text = viewModel.title
    }
    
}

//
//  TopSectinCell.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit
import Kingfisher

final class TopRatedSectionCell: UICollectionViewCell {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: TopRatedSectionCell.self)
    public var viewModel: MovieViewModel? {
        didSet {
            configure()
        }
    }
    public var numberTop = 0
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "TheBatman")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let numberTopLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.font = UIFont.boldSystemFont(ofSize: 250)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 60)
        addSubview(numberTopLabel)
        numberTopLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        numberTopLabel.setWidth(frame.width/2)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        imageBackground.kf.setImage(with: viewModel.imageUrl)
        numberTopLabel.text = viewModel.topNumber
    }
}

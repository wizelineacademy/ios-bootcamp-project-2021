//
//  TopSectinCell.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class TopRatedSectionCell: UICollectionViewCell, Reusable {
    // MARK: - Properties
    public var viewModel: MovieViewModel? {
        didSet {
            configure()
        }
    }
    public var numberTop = InterfaceConst.initZeroValue
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let numberTopLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = InterfaceConst.minimumScaleFactorFontSize
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.topRatedNumberFontSize)
        label.numberOfLines = InterfaceConst.initZeroNumberLineValue
        label.shadowColor = UIColor.systemBackground
        label.shadowOffset = CGSize(width: InterfaceConst.topRatedNumberShadowWidthOffset, height: InterfaceConst.topRatedNumberShadowHightOffset)
    
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
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: InterfaceConst.topRatedNumberPadding)
        addSubview(numberTopLabel)
        numberTopLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        numberTopLabel.setWidth(frame.width / InterfaceConst.divideInto2)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        imageBackground.setImageFromNetwork(withURL: viewModel.imageUrl)
        numberTopLabel.text = viewModel.topNumber
    }
}

//
//  CastCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import UIKit.UICollectionViewCell

final class CastCell: UICollectionViewCell, Reusable {

    // MARK: - Properties
    public var viewModel: CastViewModel? {
        didSet {
            configure()
        }
    }
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        return imageView
    }()
    
    private let authorNameLabel = UILabel()
    
    private let characterLabel = UILabel()
    
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
        
        addSubview(logoImageView)
        logoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        configureLabel(label: authorNameLabel, textSize: InterfaceConst.normalFontSize)
        configureLabel(label: characterLabel, textSize: InterfaceConst.fontSizeTag)
        
        let stack = UIStackView(arrangedSubviews: [authorNameLabel, characterLabel])
        stack.backgroundColor = .darkGray
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.layoutMargins = UIEdgeInsets(
            top: InterfaceConst.paddingLittle,
            left: InterfaceConst.paddingLittle,
            bottom: InterfaceConst.paddingLittle,
            right: InterfaceConst.paddingLittle
        )
        stack.isLayoutMarginsRelativeArrangement = true
        
        addSubview(stack)
        stack.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
        
        stack.setHeight((frame.height / InterfaceConst.divideInto3))

    }
    
    private func configureLabel(label: UILabel, textSize: CGFloat) {
        label.font = UIFont.systemFont(ofSize: textSize)
        label.numberOfLines = InterfaceConst.initZeroNumberLineValue
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        characterLabel.text = viewModel.character
        authorNameLabel.text = viewModel.name
        logoImageView.setImageFromNetwork(withURL: viewModel.imageUrl)

    }
    
}

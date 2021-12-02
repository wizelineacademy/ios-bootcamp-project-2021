//
//  HighSectionCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import Foundation
import UIKit

final class HightSectionCell: UICollectionViewCell, Reusable {
 
    // MARK: - Properties
    public var viewModel: MovieViewModel? {
        didSet {
            configure()
        }
    }
    
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.titleFontSize)
        label.textColor = .white
        return label
    }()
    
    private lazy var viewTitle: UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(InterfaceConst.oneValue).cgColor,
                                UIColor.black.withAlphaComponent(InterfaceConst.initZeroValue).cgColor]
        gradientLayer.frame = CGRect(
            x: InterfaceConst.initZeroValue,
            y: InterfaceConst.initZeroValue,
            width: frame.width,
            height: frame.height / InterfaceConst.divideInto4
        )
        gradientLayer.startPoint = CGPoint(x: InterfaceConst.oneValue, y: InterfaceConst.oneValue)
        gradientLayer.endPoint = CGPoint(x: InterfaceConst.oneValue, y: InterfaceConst.initZeroValue)
        view.layer.insertSublayer(gradientLayer, at: InterfaceConst.zeroPositionSublayer)
        return view
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
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(viewTitle)
        viewTitle.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        viewTitle.setHeight(frame.height / InterfaceConst.divideInto4)
        
        viewTitle.addSubview(titleLabel)
        titleLabel.centerY(inView: viewTitle)
        titleLabel.centerX(inView: viewTitle)
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        
        self.imageBackground.setImageFromNetwork(withURL: viewModel.imageUrl)
        
        titleLabel.text = viewModel.title
    }
}

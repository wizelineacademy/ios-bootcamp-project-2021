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
    
    private let imageBackground = BackgroundImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Batman"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var viewTitle: UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 4)
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
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
        viewTitle.setHeight(frame.height / 4)
        
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

//
//  DefaultSection.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

final class DefaultSectionCell: UICollectionViewCell, Reusable {
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
        imageView.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        imageView.backgroundColor = .darkGray
        return imageView
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
    }
    
    public func configure() {
        guard let viewModel = viewModel else { return }
        self.imageBackground.setImageFromNetwork(withURL: viewModel.imageUrl)
    
    }
}

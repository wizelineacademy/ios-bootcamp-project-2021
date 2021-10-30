//
//  DefaultSecction.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

class DefaultSectionCell: UICollectionViewCell, MovieCellProtocol {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: DefaultSectionCell.self)
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "TheBatmanPoster")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    internal func configureUI() {
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    
}

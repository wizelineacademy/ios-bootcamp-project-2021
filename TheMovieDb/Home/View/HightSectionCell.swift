//
//  HighSecctionCell.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import Foundation
import UIKit

class HightSectionCell: UICollectionViewCell, MovieCellProtocol {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: HightSectionCell.self)
    
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "TheBatmanBackground")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Batman"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    internal func configureUI() {
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        titleLabel.anchor(bottom: bottomAnchor, paddingBottom: 20)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    // MARK: - Actions
    
}

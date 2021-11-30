//
//  DetailHeaderCollectionView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 23/11/21.
//

import UIKit

final class DetailHeaderCollectionView: UICollectionReusableView {
    static let reuseIdentifier = "header-detail-reuse-identifier"
    var viewModelMovie: MovieViewModel? {
        didSet {
            configure()
        }
    }
    
    lazy var vwContainer: UIView = {
        let vwContainer = UIView()
        vwContainer.translatesAutoresizingMaskIntoConstraints = false
        return vwContainer
    }()
    
    lazy var imvPoster: UIImageView = {
        let imvPoster = UIImageView()
        imvPoster.translatesAutoresizingMaskIntoConstraints = false
        return imvPoster
    }()
    
    lazy var lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.numberOfLines = 0
        lblTitle.adjustsFontForContentSizeCategory = true
        return lblTitle
    }()
    
    lazy var lblDescription: UILabel = {
        let lblDescription = UILabel()
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        lblDescription.numberOfLines = 0
        lblDescription.adjustsFontForContentSizeCategory = true
        return lblDescription
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension DetailHeaderCollectionView {
    func configure() {
        backgroundColor = .systemBackground
        
        self.addSubview(vwContainer)
       
        imvPoster.loadImage(urlString: viewModelMovie?.image ?? "")
        imvPoster.layer.cornerRadius = 4
        imvPoster.clipsToBounds = true
        vwContainer.addSubview(imvPoster)
        
        lblTitle.text = viewModelMovie?.title
        lblTitle.font = UIFont.preferredFont(forTextStyle: .title1)
        vwContainer.addSubview(lblTitle)
        
        lblDescription.text = viewModelMovie?.overview
        lblTitle.font = UIFont.preferredFont(forTextStyle: .body)
        vwContainer.addSubview(lblDescription)
       
        let spacing = CGFloat(8)
        NSLayoutConstraint.activate([
            vwContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vwContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vwContainer.topAnchor.constraint(equalTo: self.topAnchor),
            vwContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imvPoster.centerYAnchor.constraint(equalTo: vwContainer.centerYAnchor),
            imvPoster.heightAnchor.constraint(equalTo: imvPoster.widthAnchor, multiplier: 3/2),
            imvPoster.widthAnchor.constraint(equalTo: vwContainer.widthAnchor, multiplier: 0.3),
            imvPoster.leadingAnchor.constraint(equalTo: vwContainer.leadingAnchor, constant: spacing),
            
            lblTitle.leadingAnchor.constraint(equalTo: imvPoster.trailingAnchor, constant: spacing),
            lblTitle.trailingAnchor.constraint(equalTo: vwContainer.trailingAnchor, constant: -spacing ),
            lblTitle.topAnchor.constraint(equalTo: imvPoster.topAnchor),
          
            lblDescription.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: spacing * 2),
            lblDescription.leadingAnchor.constraint(equalTo: lblTitle.leadingAnchor),
            lblDescription.trailingAnchor.constraint(equalTo: lblTitle.trailingAnchor),
            lblDescription.bottomAnchor.constraint(lessThanOrEqualTo: vwContainer.bottomAnchor, constant: spacing)
            
        ])
    }
    
}

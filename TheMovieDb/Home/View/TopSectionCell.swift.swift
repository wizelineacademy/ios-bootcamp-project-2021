//
//  TopSectinCell.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit
import Kingfisher

class TopSectionCell: UICollectionViewCell, MovieCellProtocol {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: TopSectionCell.self)
    
    public var numberTop = 0
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "TheBatman")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let numberTopLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
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
    internal func configureUI() {
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 60)
        addSubview(numberTopLabel)
        numberTopLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: -10)
        numberTopLabel.setDimensions(height: frame.height - 50, width: frame.width/2)
    }
    
    public func withMovie(with movie: Movie) {
        numberTopLabel.text = "\(numberTop + 1)"
        let urlImage = MovieConst.imageCDN + (movie.posterPath ?? "")
        let url = URL(string: urlImage )
        imageBackground.kf.setImage(with: url)
    }
    
    // MARK: - Actions
    
}

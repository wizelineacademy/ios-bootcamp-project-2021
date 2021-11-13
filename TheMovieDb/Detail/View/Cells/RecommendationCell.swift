//
//  RecommendationCell.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 13/11/21.
//

import UIKit
import Kingfisher

final class RecommendationCell: UICollectionViewCell {
    
    static let identifier: String = "recommendation-cell"
    
    private lazy var imagePoster: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var movie: MovieModel? {
        didSet {
            let url = URL(string: "https://image.tmdb.org/t/p/w185\(movie?.posterPath ?? "")")
            imagePoster.kf.setImage(with: url, placeholder: UIImage.posterPlaceholder)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension RecommendationCell {
    
    func setup() {
        layer.cornerRadius = 8
        addSubview(imagePoster)
        setupImagePosterConstraints()
    }
    
    func setupImagePosterConstraints() {
        imagePoster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imagePoster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imagePoster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imagePoster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
}

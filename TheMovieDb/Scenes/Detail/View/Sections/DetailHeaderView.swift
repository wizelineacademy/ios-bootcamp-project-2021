//
//  DetailHeaderView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 04/11/21.
//

import UIKit
import Kingfisher

final class DetailHeaderView: UICollectionReusableView {
    
    static let identifier: String = "details-header-identifier"
    
    private lazy var imageBackdrop: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var gradientView: GradientView = {
        let view = GradientView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.finalColor = UIColor.black
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        let point = UIFont.preferredFont(forTextStyle: .title1).pointSize
        label.font = UIFont.boldSystemFont(ofSize: point)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movie: MovieModel? {
        didSet {
            let url: String = "https://image.tmdb.org/t/p/w780\(movie?.backdropPath ?? "")"
            imageBackdrop.kf.setImage(with: URL(string: url),
                                      placeholder: UIImage.posterPlaceholder)
            titleLabel.text = movie?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
}

private extension DetailHeaderView {
    private func setup() {
        addSubview(imageBackdrop)
        addSubview(gradientView)
        addSubview(titleLabel)
        imageBackdropConstraints()
        gradientViewConstraints()
        titleLabelConstraints()
    }
    
    private func imageBackdropConstraints() {
        imageBackdrop.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageBackdrop.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageBackdrop.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        imageBackdrop.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func gradientViewConstraints() {
        gradientView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        gradientView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        gradientView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func titleLabelConstraints() {
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}

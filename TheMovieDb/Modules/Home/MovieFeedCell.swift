//
//  MovieFeedCell.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 29/10/21.
//

import UIKit

final class MoviesFeedCell: UICollectionViewCell {
    
    static let cellIdentifier = "MoviesFeedCell"
    
    let cache = Cache<String, UIImage>()
    
    private lazy var poster: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        activateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(poster)
    }
    
    func activateConstraints() {
        poster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: contentView.topAnchor),
            poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateUI(withMoviePoster posterImage: UIImage?) {
        if posterImage == nil {
            poster.contentMode = .scaleAspectFit
        }
        poster.image = posterImage ?? UIImage(named: "moviePosterPlaceholder")
    }
}

//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 01/11/21.
//

import UIKit
import Kingfisher

class MovieCellController: UICollectionViewCell {
    static let cellIdentifier = "MovieCell"
    
    lazy private var movieImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return view
    }()
    
    lazy private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .fill
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        
        view.addArrangedSubview(starImageView)
        view.addArrangedSubview(movieRating)
        return view
    }()
    
    lazy private var movieRating: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return view
    }()
    
    lazy private var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var movieTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        view.setContentCompressionResistancePriority(UILayoutPriority(751), for: .vertical)
        return view
    }()
    
    var movieItem: MovieItem? {
        didSet {
            self.movieTitle.text = movieItem?.title
            if let voteAverage = movieItem?.voteAverage {
                self.movieRating.text = String(voteAverage)
            }
        }
    }
    
    var configurationImage: ConfigurationImage? {
        didSet {
            if let posterURL = movieItem?.getPosterURL(baseURL: configurationImage?.secureBasePosterURL) {
                self.movieImage.kf.indicatorType = .activity
                self.movieImage.kf.setImage(
                    with: posterURL,
                    placeholder: UIImage(systemName: "film"),
                    options: nil,
                    completionHandler: nil)
            }
        }
    }
    
    // General margin for ui elements
    private let margin: CGFloat = 5
    
    // General corner radius
    private let cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(movieImage)
        addSubview(stackView)
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            stackView.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: margin),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            
            movieTitle.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: margin),
            movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin),
            movieTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin)
        ])
        self.contentView.layer.cornerRadius = cornerRadius
        self.contentView.layer.backgroundColor = UIColor.secondarySystemFill.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImage.image = nil
        movieRating.text = nil
        movieTitle.text = nil
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
}

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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy private var stackView: UIStackView = {
        let view = UIStackView()
        let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
        starImageView.tintColor = .systemYellow
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .fill
        view.addSubview(starImageView)
        view.addSubview(movieRating)
        return view
    }()
    
    lazy private var movieRating: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .green
        view.setContentHuggingPriority(UILayoutPriority(250), for: .horizontal)
        return view
    }()
    
    lazy private var movieTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = .label
        return view
    }()
    
    var movieItem: MovieItem? {
        didSet {
            self.movieImage.image = UIImage(named: "test_image")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.backgroundColor = UIColor.secondarySystemFill.cgColor
        
        addSubview(movieImage)
        addSubview(stackView)
        addSubview(movieTitle)
        
        NSLayoutConstraint.activate([
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            stackView.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            
            movieTitle.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            movieTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            movieTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5),
            movieTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        movieImage.image = nil
        movieRating.text = nil
        movieTitle.text = nil
    }
}

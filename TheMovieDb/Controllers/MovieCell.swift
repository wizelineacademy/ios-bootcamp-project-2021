//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 01/11/21.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    static let cellIdentifier = "MovieCell"
    
    var movieItem: MovieItem? {
        didSet {
            self.movieImage.image = UIImage(named: "test_image")
            self.movieTitle.text = movieItem?.title
            if let voteAverage = movieItem?.voteAverage {
                self.movieRating.text = String(voteAverage)
            }
        }
    }
    
    var configurationImages: ConfigurationImages? {
        didSet {
            if let posterURL = movieItem?.getPosterURL(baseURL: configurationImages?.secureBasePosterURL) {
                self.movieImage.kf.indicatorType = .activity
                self.movieImage.kf.setImage(
                    with: posterURL,
                    placeholder: UIImage(systemName: "film"),
                    options: nil,
                    completionHandler: nil)
            }
        }
    }

    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieRating: UILabel!
    @IBOutlet var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI() {
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.backgroundColor = UIColor.secondarySystemFill.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.movieImage.image = nil
        self.movieRating.text = nil
        self.movieTitle.text = nil
    }
}

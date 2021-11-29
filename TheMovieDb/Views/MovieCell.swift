//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.originalTitle, releaseDate: movie.releaseDate, rating: movie.voteAverage, overview: movie.overview, poster: movie.posterPath)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        self.movieTitleLabel.text = title
        self.movieTitleLabel.adjustsFontSizeToFitWidth = true

        self.releaseDateLabel.text = releaseDate?.readableDate()
        guard let average = rating else { return }
        self.ratingLabel.text = Utils.showStar(value: Int(average))
        self.movieOverviewLabel.text = overview
        
        guard let posterPath = poster else { return }
        urlString = "\(Constants.URLS.imageURL)\(posterPath)"
        
        if let imageURL = URL(string: urlString) {
            movieImageView.kf.setImage(with: imageURL)
            movieImageView.layer.cornerRadius = movieImageView.frame.size.width / 9
        }
        
    }
    
}

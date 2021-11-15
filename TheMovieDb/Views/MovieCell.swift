//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    private var urlString: String = ""
    
    func setCellWithValuesOf(_ movie:Movie){
        updateUI(title: movie.originalTitle, releaseDate: movie.releaseDate, rating: movie.voteAverage, overview: movie.overview, poster: movie.posterPath)
    }
    
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?){
        self.movieTitleLabel.text = title
        self.movieTitleLabel.adjustsFontSizeToFitWidth = true

        self.releaseDateLabel.text = fixedDateFormatter(releaseDate)
        guard let average = rating else { return }
        self.ratingLabel.text =  showStar(value: Int(average * 10))
        self.movieOverviewLabel.text = overview
        
        guard let posterPath = poster else { return }
        urlString = "\(Constants.URLS.imageURL)\(posterPath)"
        
        if let imageURL = URL(string: urlString){
            movieImageView.imageFetcher(url: imageURL)
        }
        
    }
    
}

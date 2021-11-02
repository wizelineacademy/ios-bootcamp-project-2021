//
//  MovieFeedCell.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 29/10/21.
//

import UIKit
import Kingfisher

final class MoviesFeedCell: UICollectionViewCell {
    
    static let cellIdentifier = "MoviesFeedCell"
    
    @IBOutlet weak var poster: UIImageView!
    
    func updateUI(withMovie movie: Movie) {
        if let posterpath = movie.posterPath,
           let posterURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterpath)") {
            poster.kf.setImage(with: posterURL)
        }
    }
}

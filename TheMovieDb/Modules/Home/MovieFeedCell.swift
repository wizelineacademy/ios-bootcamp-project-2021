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
    
    @IBOutlet weak var poster: UIImageView!
    
    func updateUI(withMovie movie: Movie) {
        if let posterpath = movie.posterPath,
           let posterURL = URL(string: MovieDBAPI.APIConstants.imageUrl + posterpath) {
            if let cached = cache[posterURL.absoluteString] {
                poster.image = cached
            } else {
                poster.load(url: posterURL) { [weak self] image in
                    self?.cache[posterURL.absoluteString] = image
                }
            }
        }
    }
}

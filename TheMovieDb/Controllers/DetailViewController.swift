//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 05/11/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    var moviePoster: UIImageView!
    var movieTitle: UILabel!
    var movieMediaType: UILabel!
    var movieReleaseDate: UILabel!
    var movieOverview: UILabel!
    var movieRating: UILabel!

    var configurationImage: ConfigurationImage?
    var movieItem: MovieItem?
    
    static let segueIdentifier = "goToMovieDetalSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        guard let movieItem = movieItem else {
            return
        }
        
        guard var configurationImage = configurationImage else {
            return
        }
        
        if let posterURL = movieItem.getPosterURL(baseURL: configurationImage.secureBasePosterURL) {
            self.moviePoster.kf.indicatorType = .activity
            self.moviePoster.kf.setImage(
                with: posterURL,
                placeholder: UIImage(systemName: "film"),
                options: nil,
                completionHandler: nil)
        }
        
        self.movieTitle.text = movieItem.title
        self.movieMediaType.text = movieItem.mediaType
        self.movieReleaseDate.text = movieItem.releaseDate
        self.movieOverview.text = movieItem.overview
        if let voteAverage = movieItem.voteAverage {
            self.movieRating.text = String(voteAverage)
        }

    }

    @IBAction func closeView(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

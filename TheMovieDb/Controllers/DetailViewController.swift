//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 05/11/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieMediaType: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieRating: UILabel!

    var configurationImages: ConfigurationImages?
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
        
        guard var configurationImages = configurationImages else {
            return
        }
        
        if let posterURL = movieItem.getPosterURL(baseURL: configurationImages.secureBasePosterURL) {
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

}

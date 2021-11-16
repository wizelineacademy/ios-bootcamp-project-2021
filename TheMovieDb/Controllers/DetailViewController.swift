//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    //var movieManager = MovieManager()
    var MovieData: Movie?
    
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailGenreLabel: UILabel!
    @IBOutlet weak var detailMovieImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(MovieData)
        
        detailTitleLabel.text = MovieData?.originalTitle
        detailTitleLabel.adjustsFontSizeToFitWidth = true

        detailDateLabel.text = fixedDateFormatter(MovieData?.releaseDate)
        guard let average = MovieData?.voteAverage else { return }
        detailRatingLabel.text = "\(average) " + showStar(value: Int(average * 10))
        
        detailDescriptionLabel.text = MovieData?.overview
        guard let backdropPath = MovieData?.backdropPath else { return }
        let urlString = "\(Constants.URLS.imageURL)\(backdropPath)"
        
        if let imageURL = URL(string: urlString){
            detailMovieImage.kf.setImage(with: imageURL)
        }

        
    }
    

    
}

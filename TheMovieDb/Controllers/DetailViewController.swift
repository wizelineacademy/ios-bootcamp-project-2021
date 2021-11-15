//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit

import UIKit

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
        let urlString = "https://image.tmdb.org/t/p/w500\(backdropPath)"
        
        if let imageURL = URL(string: urlString){
            detailMovieImage.posterFetcher(url: imageURL)
        }
        
        func fixedDateFormatter(_ date: String?) -> String {
            var fixDate: String = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyy-MM-dd"
            if let originalDate = date {
                if let newDate = dateFormatter.date(from: originalDate) {
                    dateFormatter.dateFormat = "dd.MM.yyyy"
                    fixDate = dateFormatter.string(from: newDate)
                }
            }
            return fixDate
        }
        
        func showStar(value: Int ) -> String {
            var star: String = ""
            if value < 20 && value >= 0{
                star = "★☆☆☆☆"
            }
            else if value < 50 {
                star = "★★☆☆☆"
            }
            else if value < 70 {
                star = "★★★☆☆"
            }
            else if value < 90 {
                star = "★★★★☆"
            }
            else if value <= 100{
                star = "★★★★★"
            }
            else {
                star = "TBD"
            }
            return star;
            
        }

        
    }
    

    
}

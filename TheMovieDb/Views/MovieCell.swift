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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showStar(value:Int ) ->String{
        var star:String = ""
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
    
    func setCellWithValuesOf(_ movie:Movie){
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?){
        self.movieTitleLabel.text = title
        self.releaseDateLabel.text = fixedDateFormatter(releaseDate)
        guard let average = rating else { return }
        self.ratingLabel.text =  showStar(value: Int(average * 10))
        self.movieOverviewLabel.text = overview
        
        guard let posterPath = poster else { return }
        urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        
        if let imageURL = URL(string: urlString){
            movieImageView.posterFetcher(url: imageURL)
        }
        
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
    
}

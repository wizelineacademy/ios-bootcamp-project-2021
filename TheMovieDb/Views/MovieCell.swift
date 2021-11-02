//
//  MovieCell.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: - Average to star values

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
    
    // MARK: - Place movie info into IBOUTlets, im changing this later
    
    func setMovieInfo(movie: MovieInfo) {
            movieTitleLabel.text = movie.title
        guard let voteAverage = movie.vote_average else{
            return
        }
            ratingLabel.text = showStar(value: Int(voteAverage * 10))
            movieOverviewLabel.text = movie.overview
            releaseDateLabel.text = movie.release_date
        guard let posterPath = movie.poster_path else {
            return
        }
        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
            movieImageView.posterFetcher(url: imageURL)
        }
        
    }
}

// MARK: - extends UIImageView to fetch posters, bad implemented but it works.


extension UIImageView {

func posterFetcher(url: URL, contentMode mode:  UIView.ContentMode = .scaleAspectFit) {

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                return
                }
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }.resume()
    }

}


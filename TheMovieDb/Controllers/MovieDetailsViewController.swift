//
//  MovieDetailsViewController.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 15/11/21.
//

import UIKit

final class DetailsViewController: UIViewController {
    var movie: Movie?
    let basePosterUrl = "https://image.tmdb.org/t/p/w500"
    let detailView = DetailView()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // view = detailView // Overrides the view
//        view.addSubview(detailView) // Subview
        let imageUrl = URL(string: basePosterUrl + (movie?.posterPath)!)
        posterImageView.kf.setImage(with: imageUrl)
        titleLabel.text = movie?.title
        releaseDate.text = movie?.releaseDate
        overviewLabel.text = movie?.overview
        
    }
    
}

final class DetailView: UIView {
    @IBOutlet weak var titleLabel: UILabel! = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel! = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // titleLabel.numberOfLines = 0
    
    // overviewLabel.numberOfLines = 0
}

//
//  MovieDetailsViewController.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 15/11/21.
//

import UIKit
import SwiftUI

final class DetailsViewController: UIHostingController<DetailsSwiftUIView> {
    var movie: Movie?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DetailsSwiftUIView(movie: movie))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else { return }
        self.rootView = DetailsSwiftUIView(movie: movie)

    }
    /*func getCast(movieId: Int, Completion: @escaping (Cast) -> Void) {
        let getCastRepo = GetCast()
        var credits: [Cast] = []
        getCastRepo.getCredits(option: .cast(movieId: movieId)) { Credits in
            credits.append(contentsOf: Credits.cast)
        }
    }*/
}

/*final class DetailsViewController: UIViewController {
    var movie: Movie?
    let basePosterUrl = "https://image.tmdb.org/t/p/w500"
    let detailView = DetailView()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        let imageUrl = URL(string: basePosterUrl + (movie?.posterPath)!)
        posterImageView.kf.setImage(with: imageUrl)
        titleLabel.text = movie?.title
        releaseDate.text = movie?.releaseDate
        overviewLabel.text = movie?.overview
        
    }
    
}*/

/*final class DetailView: UIView {
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
}*/

//
//  MovieInfoViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit
import Kingfisher

class MovieInfoViewController: UIViewController {
    
    var movie: Movie?
    var movieID: Int?
    
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var textOverview: UITextView!
    
    @IBOutlet weak var idMovie: UILabel!
    
    @IBOutlet weak var originalTitleMovie: UILabel!
    
    @IBOutlet weak var originalLanguageMovie: UILabel!
    
    @IBOutlet weak var popularityMovie: UILabel!
    
    @IBOutlet weak var adultMovie: UILabel!
    
    @IBOutlet weak var releaseDateMovie: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if let _ = movieID {
            detailMovieID()
        } else {
            detailMovie()
        }
    }
    
    func detailMovie() {
        titleMovie.text = movie?.title
        imageMovie.setImage(path: movie?.posterPath)
        textOverview.text = "Overview: \(movie?.overview ?? "Unavailable")"
        originalTitleMovie.text = "Original Title: \(movie?.originalTitle ?? "Unavailable")"
        originalLanguageMovie.text = "Original Language: \(movie?.originalLanguage ?? "Unavailable")"
        popularityMovie.text = "Popularity: \(movie?.popularity ?? 0.0)"
        idMovie.text = "ID: \(movie?.id ?? 0)"
        adultMovie.text = "Adult Movie: \(movie?.adult ?? false)"
        releaseDateMovie.text = "Release Date: \(movie?.releaseDate ?? "Unavailable")"
    }
    
    func detailMovieID() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .movieDetails(id: id)) { [weak self] (response: Result<Movie, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movie):
                self.movie = movie
                DispatchQueue.main.async {
                    self.detailMovie()
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }
}


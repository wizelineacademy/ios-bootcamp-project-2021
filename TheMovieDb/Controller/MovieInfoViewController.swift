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
    var similarMoviesNames: String?
    var recommendedMoviesNames: String?
    var castMovie: String?
    
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var imageMovie: UIImageView!
    
    @IBOutlet weak var textOverview: UITextView!
    
    @IBOutlet weak var idMovie: UILabel!
    
    @IBOutlet weak var originalTitleMovie: UILabel!
    
    @IBOutlet weak var originalLanguageMovie: UILabel!
    
    @IBOutlet weak var popularityMovie: UILabel!
    
    @IBOutlet weak var adultMovie: UILabel!
    
    @IBOutlet weak var releaseDateMovie: UILabel!
    
    @IBOutlet weak var castInfoLabel: UILabel!
    
    @IBOutlet weak var similarMoviesLabel: UILabel!
    
    @IBOutlet weak var recommendationsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        if let _ = movieID {
            detailMovieID()
        } else if let movie = movie {
            movieID = movie.id
            detailMovie()
        }
        
        similarMovies()
        recomendedMovies()
        castFromMovie()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reviews", style: .plain, target: self, action: #selector(reviewsDisplay))
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
    
    func similarMovies() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .similar(id: id)) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movieResponse):
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.similarMoviesNames = movieNames?.joined(separator: ", ")
                DispatchQueue.main.async {
                    self.similarMoviesLabel.text = "Similar movies: \(self.similarMoviesNames ?? "None")"
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }
    
    func recomendedMovies() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .recommendations(id: id)) { [weak self] (response: Result<MovieResponse<Movie>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movieResponse):
                let movies = movieResponse.results
                let movieNames = movies?.compactMap({ $0.title }).prefix(3)
                self.recommendedMoviesNames = movieNames?.joined(separator: ", ")
                DispatchQueue.main.async {
                    self.recommendationsLabel.text = "Recommendations: \(self.recommendedMoviesNames ?? "None")"
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }
    
    func castFromMovie() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .credits(id: id)) { [weak self] (response: Result<CreditsMovie, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let creditsResponse):
                let castMovie = creditsResponse.cast
                let castNames = castMovie?.compactMap({ $0.name }).prefix(3)
                self.castMovie = castNames?.joined(separator: ", ")
                DispatchQueue.main.async {
                    self.castInfoLabel.text = "Cast: \(self.castMovie ?? "None")"
                }
            case .failure(let failureResult):
                print(failureResult.localizedDescription)
            }
        }
    }
    
   @objc func reviewsDisplay() {
       if let vc = storyboard?.instantiateViewController(identifier: "Reviews") as? ReviewsViewController {
           vc.movieID = movie?.id
           navigationController?.pushViewController(vc, animated: true)
       }
    }
}

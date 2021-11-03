//
//  MovieInfoViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit
import Kingfisher

final class MovieInfoViewController: UIViewController {
    
    var movieID: Int?
    var movie: Movie? {
        didSet {
            DispatchQueue.main.async {
                self.setupMovieInfoUI()
            }
        }
    }
    
    var similarMoviesNames: String? {
        didSet {
            DispatchQueue.main.async {
                self.similarMoviesLabel.text = "Similar movies: \(self.similarMoviesNames ?? "None")"
            }
        }
    }
    var recommendedMoviesNames: String? {
        didSet {
            DispatchQueue.main.async {
                self.recommendationsLabel.text = "Recommendations: \(self.recommendedMoviesNames ?? "None")"
            }
        }
    }
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
        
        setupNavigationBar()
        setupMovie()
        similarMovies()
        recomendedMovies()
        castFromMovie()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.reviewsTitleBarButton, style: .plain, target: self, action: #selector(reviewsDisplay))
    }
    
    func setupMovie() {
        if let _ = movieID {
            getMovieDetail()
        } else if let movie = movie {
            movieID = movie.id
            setupMovieInfoUI()
        }
    }
    
    func setupMovieInfoUI() {
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
    
    func getMovieDetail() {
        guard let id = movieID else { return }
        MovieFacade.get(endpoint: .movieDetails(id: id)) { [weak self] (response: Result<Movie, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let movie):
                self.movie = movie
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
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
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
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
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
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
                self.showErrorAlert(failureResult)
            }
        }
    }
    
   @objc func reviewsDisplay() {
       if let viewControllerReviews = storyboard?.instantiateViewController(identifier: Constants.reviewsViewControllerID) as? ReviewsViewController {
           viewControllerReviews.movieID = movie?.id
           navigationController?.pushViewController(viewControllerReviews, animated: true)
       }
    }
}

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
    var castMovie: String? {
        didSet {
            DispatchQueue.main.async {
                self.castInfoLabel.text = "Cast: \(self.castMovie ?? "None")"
            }
        }
    }
    
    let titleMovie = UILabel()
    let imageMovie = UIImageView()
    let textOverview = UITextView()
    let idMovie = UILabel()
    let originalTitleMovie = UILabel()
    let originalLanguageMovie = UILabel()
    let popularityMovie = UILabel()
    let adultMovie = UILabel()
    let releaseDateMovie = UILabel()
    let castInfoLabel = UILabel()
    let similarMoviesLabel = UILabel()
    let recommendationsLabel = UILabel()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addAllViews()
        setupTitleMovieLabel()
        setupImageMovie()
        setupTextOverview()
        setupStackView()
        setupMovie()
        similarMovies()
        recomendedMovies()
        castFromMovie()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func addAllViews() {
        view.addSubview(titleMovie)
        view.addSubview(imageMovie)
        view.addSubview(textOverview)
        view.addSubview(stackView)
        view.backgroundColor = .white
    }
    
    private func setupTitleMovieLabel() {
        titleMovie.translatesAutoresizingMaskIntoConstraints = false
        titleMovie.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleMovie.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleMovie.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 20).isActive = true
        titleMovie.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleMovie.textAlignment = .center
        titleMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleMovie.numberOfLines = 2
    }
    
    private func setupImageMovie() {
        imageMovie.translatesAutoresizingMaskIntoConstraints = false
        imageMovie.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 10).isActive = true
        imageMovie.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        imageMovie.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20).isActive = true
        imageMovie.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageMovie.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageMovie.heightAnchor.constraint(equalTo: imageMovie.widthAnchor, multiplier: 1.5).isActive = true
    }
    
    private func setupTextOverview() {
        textOverview.translatesAutoresizingMaskIntoConstraints = false
        textOverview.topAnchor.constraint(equalTo: imageMovie.bottomAnchor, constant: 10).isActive = true
        textOverview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textOverview.trailingAnchor, constant: 20).isActive = true
        textOverview.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textOverview.isEditable = false
        textOverview.font = .systemFont(ofSize: 15)
        castInfoLabel.numberOfLines = 2
        similarMoviesLabel.numberOfLines = 2
        recommendationsLabel.numberOfLines = 2
    }
    
    private func setupStackView() {
        idMovie.translatesAutoresizingMaskIntoConstraints = false
        originalTitleMovie.translatesAutoresizingMaskIntoConstraints = false
        originalLanguageMovie.translatesAutoresizingMaskIntoConstraints = false
        popularityMovie.translatesAutoresizingMaskIntoConstraints = false
        adultMovie.translatesAutoresizingMaskIntoConstraints = false
        releaseDateMovie.translatesAutoresizingMaskIntoConstraints = false
        castInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        similarMoviesLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendationsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: textOverview.bottomAnchor, constant: 10).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 20).isActive = true
        
        stackView.addArrangedSubview(idMovie)
        stackView.addArrangedSubview(originalTitleMovie)
        stackView.addArrangedSubview(originalLanguageMovie)
        stackView.addArrangedSubview(popularityMovie)
        stackView.addArrangedSubview(adultMovie)
        stackView.addArrangedSubview(releaseDateMovie)
        stackView.addArrangedSubview(castInfoLabel)
        stackView.addArrangedSubview(similarMoviesLabel)
        stackView.addArrangedSubview(recommendationsLabel)
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
                guard movieResponse.results?.count ?? 0 > 0 else { return }
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
            case .failure(let failureResult):
                self.showErrorAlert(failureResult)
            }
        }
    }
    
   @objc func reviewsDisplay() {
       let viewControllerReviews = ReviewsViewController()
       viewControllerReviews.movieID = movie?.id
       navigationController?.pushViewController(viewControllerReviews, animated: true)
       }
}

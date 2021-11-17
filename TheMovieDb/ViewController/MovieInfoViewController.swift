//
//  MovieInfoViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit

final class MovieInfoViewController: UIViewController {
    
    var viewModel: MovieInfoViewModel = .init(facade: MovieFacade())
    
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
        setupClosures()
        viewModel.fetchServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupClosures() {
        viewModel.showError = { [weak self] error in self?.showErrorAlert(error) }
        viewModel.loadMovieInfo = { [weak self] in self?.setupMovieInfoUI() }
        viewModel.loadSimilarMovies = { [weak self] in self?.similarMoviesLabel.text = "Similar movies: \(self?.viewModel.similarMoviesNames ?? "None")" }
        viewModel.loadRecommendedMovies = { [weak self] in self?.recommendationsLabel.text = "Recommendations: \(self?.viewModel.recommendedMoviesNames ?? "None")" }
        viewModel.loadCastMovie = { [weak self] in self?.castInfoLabel.text = "Cast: \(self?.viewModel.castMovie ?? "None")"}
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
    
    func setupMovieInfoUI() {
        titleMovie.text = viewModel.movie?.title
        imageMovie.setImage(path: viewModel.movie?.posterPath)
        textOverview.text = "Overview: \(viewModel.movie?.overview ?? "Unavailable")"
        originalTitleMovie.text = "Original Title: \(viewModel.movie?.originalTitle ?? "Unavailable")"
        originalLanguageMovie.text = "Original Language: \(viewModel.movie?.originalLanguage ?? "Unavailable")"
        popularityMovie.text = "Popularity: \(viewModel.movie?.popularity ?? 0.0)"
        idMovie.text = "ID: \(viewModel.movie?.id ?? 0)"
        adultMovie.text = "Adult Movie: \(viewModel.movie?.adult ?? false)"
        releaseDateMovie.text = "Release Date: \(viewModel.movie?.releaseDate ?? "Unavailable")"
    }
    
   @objc func reviewsDisplay() {
       let viewControllerReviews = ReviewsViewController()
       viewControllerReviews.viewModel.movieID = viewModel.movie?.id
       navigationController?.pushViewController(viewControllerReviews, animated: true)
       }
}

//
//  MovieInfoViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit
import os.log
import SwiftUI

final class MovieInfoViewController: UIViewController {
    
    var viewModel: MovieInfoViewModel?
    
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
    
    init(facade: MovieService) {
        super.init(nibName: nil, bundle: nil)
        viewModel = MovieInfoViewModel(facade: facade)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        addAllViews()
        setupTitleMovieLabel()
        setupImageMovie()
        setupTextOverview()
        setupStackView()
        setupClosures()
        viewModel?.fetchServices()
        os_log("MovieInfoViewController did load!", log: OSLog.viewCycle, type: .debug)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func setupClosures() {
        viewModel?.showError = { [weak self] error in self?.showErrorAlert(error) }
        viewModel?.loadMovieInfo = { [weak self] in self?.setupMovieInfoUI() }
        viewModel?.loadSimilarMovies = { [weak self] in
            let similar = "similar.movies".localized
            self?.similarMoviesLabel.text = String(format: similar, self?.viewModel?.similarMoviesNames ?? "unavailable".localized)
        }
        viewModel?.loadRecommendedMovies = { [weak self] in
            let recomendations = "recomendations".localized
            self?.recommendationsLabel.text = String(format: recomendations, self?.viewModel?.recommendedMoviesNames ?? "unavailable".localized)
        }
        viewModel?.loadCastMovie = { [weak self] in
            let cast = "cast".localized
            self?.castInfoLabel.text = String(format: cast, self?.viewModel?.castMovie ?? "unavailable".localized)
            }
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
        view.trailingAnchor.constraint(equalTo: titleMovie.trailingAnchor, constant: 20).isActive = true
        titleMovie.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleMovie.textAlignment = .center
        titleMovie.numberOfLines = 2
    }
    
    private func setupImageMovie() {
        imageMovie.translatesAutoresizingMaskIntoConstraints = false
        imageMovie.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 10).isActive = true
        imageMovie.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(greaterThanOrEqualTo: imageMovie.trailingAnchor, constant: 20).isActive = true
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
        titleMovie.text = viewModel?.movie?.title
        imageMovie.setImage(path: viewModel?.movie?.posterPath)
        let overview = "overview".localized
        textOverview.text = String(format: overview, viewModel?.movie?.overview ?? "unavailable".localized)
        let originalTitle = "original.title".localized
        originalTitleMovie.text = String(format: originalTitle, viewModel?.movie?.originalTitle ?? "unavailable".localized)
        let originalLanguage = "original.language.movie".localized
        originalLanguageMovie.text = String(format: originalLanguage, viewModel?.movie?.originalLanguage ?? "unavailable".localized)
        let popularity = "popularity.movie".localized
        popularityMovie.text = String(format: popularity, "\(viewModel?.movie?.popularity ?? 0.0)")
        let id = "id.movie".localized
        idMovie.text = String(format: id, "\(viewModel?.movie?.id ?? 0)")
        let adult = "adult.movie".localized
        adultMovie.text = String(format: adult, "\(viewModel?.movie?.adult ?? false ? "afirmative".localized : "negative".localized)")
        let releaseDate = "release.date.movie".localized
        releaseDateMovie.text = String(format: releaseDate, viewModel?.movie?.releaseDate ?? "unavailable".localized)
    }
    
   @objc func reviewsDisplay() {
       guard let id = viewModel?.movie?.id else { return }
       let reviewsView = ReviewsView(reviewsViewModel: .init(id: id,facade: MovieFacade()))
       let hostController = UIHostingController(rootView: reviewsView)
       navigationController?.pushViewController(hostController, animated: true)
       }
}

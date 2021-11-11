//
//  DetailView.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 06/11/21.
//

import UIKit
import Kingfisher

enum RelatedMovieTypes {
    case recommendation
    case similar
}

final class DetailView: UIViewController {
    
    private let viewModel: DetailViewModel
    
    private let loader = LoadingViewController()
    
    private lazy var scroll = UIScrollView()
    
    private lazy var mainContainer = UIView()
    
    private lazy var poster: UIImageView = {
        let iv = UIImageView()
        if let posterpath = viewModel.getMoviePosterPath(),
           let posterURL = URL(string: MovieDBAPI.APIConstants.imageUrl + posterpath) {
            iv.kf.setImage(with: posterURL)
        }
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var infoContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    private lazy var movieReleaseYear: UILabel = {
        let label = UILabel()
        label.text = viewModel.getMovieReleaseDate()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.text = viewModel.getMovieOverview()
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var similarMovies: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var recommendationMovies: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var movieCast: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        return label
    }()
    
    private var isLoading = false {
        didSet {
            if isLoading {
                add(loader)
            } else {
                loader.remove()
            }
        }
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
        addConstraints()
        requestRelatedMovieData()
    }
    
    func setupUI() {
        title = viewModel.getMovieTitle()
        view.backgroundColor = .systemBackground
        view.addSubview(scroll)
        scroll.addSubview(mainContainer)
        mainContainer.addSubview(poster)
        mainContainer.addSubview(infoContainer)
        infoContainer.addArrangedSubview(movieReleaseYear)
        infoContainer.addArrangedSubview(movieOverview)
        infoContainer.addArrangedSubview(similarMovies)
        infoContainer.addArrangedSubview(recommendationMovies)
        infoContainer.addArrangedSubview(movieCast)
    }
    
    func addConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: scroll.topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            mainContainer.widthAnchor.constraint(equalTo: scroll.widthAnchor)
        ])
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            poster.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            poster.centerXAnchor.constraint(equalTo: mainContainer.centerXAnchor),
            poster.heightAnchor.constraint(equalToConstant: 200),
            poster.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoContainer.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 10),
            infoContainer.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 10),
            infoContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -10),
            infoContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor)
        ])
    }
    
    func requestRelatedMovieData() {
        isLoading = true
        viewModel.requestRelatedMovieData { [weak self] in
            self?.isLoading = false
            self?.updateUIWithRelatedMovieData()
        }
    }
    
    func updateUIWithRelatedMovieData() {
        similarMovies.text = viewModel.getSimilarMovies()
        recommendationMovies.text = viewModel.getRecommendationMovies()
        movieCast.text = viewModel.getCast()
    }
    
}

//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 05/11/21.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    lazy private var moviePoster: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return view
    }()
    
    lazy private var movieTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .title3)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return view
    }()
    
    lazy private var movieMediaType: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .secondaryLabel
        return view
    }()
    
    lazy private var movieReleaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .secondaryLabel
        view.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return view
    }()
    
    lazy private var movieOverview: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        view.textColor = .label
        view.numberOfLines = 0
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return view
    }()
    
    lazy private var movieRating: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return view
    }()
    
    lazy private var mediaAndReleaseStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .fill
        view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        
        view.addArrangedSubview(movieMediaType)
        view.addArrangedSubview(movieReleaseDate)
        return view
    }()
    
    lazy private var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy private var ratingStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .fill
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        view.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        
        view.addArrangedSubview(starImageView)
        view.addArrangedSubview(movieRating)
        return view
    }()
    
    lazy private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(moviePoster)
        view.addSubview(movieTitle)
        view.addSubview(mediaAndReleaseStackView)
        view.addSubview(movieOverview)
        view.addSubview(ratingStackView)
        view.addSubview(showReviewsButton)
        
        return view
    }()
    
    lazy private var closeButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.close)
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            view.configuration = UIButton.Configuration.filled()
        }
        view.tintColor = .systemIndigo
        view.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return view
    }()
    
    lazy private var showReviewsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Show Reviews", for: .normal)
        if #available(iOS 15.0, *) {
            view.configuration = UIButton.Configuration.filled()
        }
        view.tintColor = .systemIndigo
        view.addTarget(self, action: #selector(showReviews), for: .touchUpInside)
        return view
    }()

    var movieViewModel: MovieViewModel?
    
    // General margin for ui elements
    private let margin: CGFloat = 10
    
    // General corner radius
    private let cornerRadius: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            moviePoster.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            moviePoster.topAnchor.constraint(equalTo: scrollView.topAnchor),
            moviePoster.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            movieTitle.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: margin),
            movieTitle.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            movieTitle.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            
            mediaAndReleaseStackView.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: margin),
            mediaAndReleaseStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            mediaAndReleaseStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            
            movieOverview.topAnchor.constraint(equalTo: mediaAndReleaseStackView.bottomAnchor, constant: margin),
            movieOverview.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            movieOverview.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            
            ratingStackView.topAnchor.constraint(equalTo: movieOverview.bottomAnchor, constant: margin),
            ratingStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            ratingStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            
            showReviewsButton.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: margin),
            showReviewsButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: margin),
            showReviewsButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -margin),
            showReviewsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        view.backgroundColor = UIColor.systemBackground
        
    }
    
    private func setupData() {
        guard var movieViewModel = movieViewModel else {
            return
        }
        
        if let posterURL = movieViewModel.posterURL {
            ImageDownloader.getImage(withURL: posterURL) { image in
                self.moviePoster.image = image
            }
        }
        
        self.movieTitle.text = movieViewModel.title
        self.movieMediaType.text = movieViewModel.mediaType
        self.movieReleaseDate.text = movieViewModel.releaseDate
        self.movieOverview.text = movieViewModel.overview
        self.movieRating.text = String(movieViewModel.rating)
    }

    @objc func closeView() {
        dismiss(animated: true)
    }
    
    @objc func showReviews() {
        guard let movieViewModel = movieViewModel else {
            return
        }
        let view = ReviewsView(movieId: movieViewModel.id, imageBaseURL: movieViewModel.baseURL)
        let hostingController = UIHostingController(rootView: view)
        present(hostingController, animated: true, completion: nil)
    }
}

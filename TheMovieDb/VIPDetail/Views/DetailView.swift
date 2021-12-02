//
//  DetailView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 30/11/21.
//

import UIKit

class DetailView: UIView {
    lazy var moviePoster: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "square")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return view
    }()
    
    lazy var movieTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .title3)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return view
    }()
    
    lazy var movieMediaType: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .secondaryLabel
        return view
    }()
    
    lazy var movieReleaseDate: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .subheadline)
        view.textColor = .secondaryLabel
        view.setContentHuggingPriority(UILayoutPriority(252), for: .horizontal)
        return view
    }()
    
    lazy var movieOverview: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .preferredFont(forTextStyle: .body)
        view.textColor = .label
        view.numberOfLines = 0
        view.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return view
    }()
    
    lazy var movieRating: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textColor = .label
        view.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        return view
    }()
    
    lazy var mediaAndReleaseStackView: UIStackView = {
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
    
    lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .systemYellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var ratingStackView: UIStackView = {
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
    
    lazy var scrollView: UIScrollView = {
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
    
    lazy var closeButton: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.close)
        view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            view.configuration = UIButton.Configuration.filled()
        }
        view.tintColor = .systemIndigo
        return view
    }()
    
    lazy var showReviewsButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Show Reviews", for: .normal)
        if #available(iOS 15.0, *) {
            view.configuration = UIButton.Configuration.filled()
        }
        view.tintColor = .systemIndigo
        return view
    }()
    
    // General margin for ui elements
    private let margin: CGFloat = 10
    
    private let bottomMargin: CGFloat = 20.0
    
    // General corner radius
    private let cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupComponents()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupComponents() {
        addSubview(scrollView)
        addSubview(closeButton)
        
        backgroundColor = UIColor.systemBackground
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            
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
            showReviewsButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -bottomMargin),
            
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}

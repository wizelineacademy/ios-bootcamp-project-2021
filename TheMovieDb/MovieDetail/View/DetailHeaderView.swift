//
//  DetailHeaderView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: DetailHeaderView.self)
    public var movie: Movie? {
        didSet {
            configure()
        }
    }
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dateLabel = TagLabel()
    
    private let votesLabel = TagLabel(colorBackground: .systemPurple)
    
    private let popularityLabel = TagLabel(colorBackground: .systemGreen)
    
    private let reviewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reviews", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.tintColor = .white
        return button
    }()
    
    private let imageBackground = BackgroundImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
       
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        imageBackground.setHeight(200)
        
        let stack = UIStackView(arrangedSubviews: [dateLabel, votesLabel, popularityLabel])
        addSubview(stack)
        stack.anchor(top: imageBackground.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        stack.distribution = .equalSpacing
        stack.setHeight(25)
        
        addSubview(reviewsButton)
        reviewsButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        reviewsButton.setHeight(30)
        
        addSubview(overviewLabel)
        overviewLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, bottom: reviewsButton.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
    }
    
    private func configure() {
        guard let movie = movie else { return }
        let urlImage = MovieConst.imageCDN + (movie.backdropPath ?? (movie.posterPath ?? ""))
        let url = URL(string: urlImage )
        imageBackground.kf.setImage(with: url)
        overviewLabel.text = movie.overview
        dateLabel.text = "   \(movie.releaseDate)   "
        popularityLabel.text = "   \(Int(movie.popularity))%   "
        votesLabel.text = "   Votes: \(movie.voteCount)   "
    }
    // MARK: - Actions
    
}

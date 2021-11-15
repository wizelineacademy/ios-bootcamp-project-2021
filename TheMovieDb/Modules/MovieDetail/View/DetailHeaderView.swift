//
//  DetailHeaderView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit
import SwiftUI
protocol DetailHeaderViewDelegate: AnyObject {
    func openReviews(_ detailHeaderView: DetailHeaderView, with movie: Movie)
}

final class DetailHeaderView: UICollectionReusableView {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: DetailHeaderView.self)
    weak var delegate: DetailHeaderViewDelegate?
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
    
    private let dateLabel = UILabel()
    
    private let votesLabel = UILabel()
    
    private let popularityLabel = UILabel()
    
    private  var stack = UIStackView()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommendations"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let reviewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reviews", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    private let imageBackground = BackgroundImageView()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureUI() {
        
        addSubview(headerLabel)
        headerLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        imageBackground.setHeight(200)
        
        stack = UIStackView(arrangedSubviews: [dateLabel, votesLabel, popularityLabel])
        addSubview(stack)
        stack.anchor(top: imageBackground.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        stack.distribution = .equalSpacing
        stack.setHeight(25)
        
        configureLabelToTag(label: dateLabel)
        configureLabelToTag(label: votesLabel, colorBackground: .systemPurple)
        configureLabelToTag(label: popularityLabel, colorBackground: .systemGreen)
        
        addSubview(reviewsButton)
        reviewsButton.anchor( left: leftAnchor, bottom: headerLabel.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        reviewsButton.setHeight(30)
        reviewsButton.addTarget(self, action: #selector(handleReview), for: .touchUpInside)
        
        addSubview(overviewLabel)
        overviewLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, bottom: reviewsButton.topAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
    }
    
    private func configure() {
        guard let movie = movie else { return }
        let urlImage = MovieConst.imageCDN + (movie.backdropPath ?? (movie.posterPath ?? ""))
        let url = URL(string: urlImage )
        imageBackground.setImageFromNetwork(withURL: url!)
        overviewLabel.text = movie.overview
        dateLabel.text = "   \(movie.releaseDate ?? "")   "
        popularityLabel.text = "   \(Int(movie.popularity))%   "
        votesLabel.text = "   Votes: \(movie.voteCount)   "
    }
    
    private func configureLabelToTag(label: UILabel, colorBackground: UIColor = .blue) {
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.layer.masksToBounds = true
        label.layer.borderColor = colorBackground.cgColor
        label.layer.borderWidth = 3.0
    }
    // MARK: - Actions
    
    @objc private func handleReview() {
        guard let movie = movie else {return}
        delegate?.openReviews(self, with: movie)
    }
}

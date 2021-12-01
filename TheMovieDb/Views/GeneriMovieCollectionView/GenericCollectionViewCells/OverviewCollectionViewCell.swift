//
//  OverviewCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 26/11/21.
//

import UIKit

class OverviewCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "overview-detail-reuse-identifier"
    var viewModelMovie: MovieViewModel? {
        didSet {
            setUpUI()
        }
    }
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy private var hStackView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.axis = .vertical
        hStackView.distribution = .fillProportionally
        hStackView.alignment = .center
        hStackView.spacing = 8
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        return hStackView
    }()
    
    lazy var popularityLabel: UILabel = {
        let popularityLabel = UILabel()
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.numberOfLines = 0
        popularityLabel.adjustsFontForContentSizeCategory = true
        return popularityLabel
    }()
    
    lazy var countVoteLabel: UILabel = {
        let countVoteLabel = UILabel()
        countVoteLabel.translatesAutoresizingMaskIntoConstraints = false
        countVoteLabel.numberOfLines = 0
        countVoteLabel.adjustsFontForContentSizeCategory = true
        return countVoteLabel
    }()
    
    lazy var realeaseDate: UILabel = {
        let realeaseDate = UILabel()
        realeaseDate.translatesAutoresizingMaskIntoConstraints = false
        realeaseDate.numberOfLines = 0
        realeaseDate.adjustsFontForContentSizeCategory = true
        return realeaseDate
    }()
    
    lazy var starImage: UIImageView = {
        let starImage = UIImageView()
        starImage.translatesAutoresizingMaskIntoConstraints = false
        starImage.image = UIImage(systemName: "star.fill")
        starImage.tintColor = .yellow
        return starImage
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OverviewCollectionViewCell {
    
    func setUpUI() {
        
        self.addSubview(stackView)
        realeaseDate.text = "Release: \n\(viewModelMovie?.releaseDate ?? "0")"
        countVoteLabel.text = "Votes: \n\(viewModelMovie?.voteAverage ?? "0") / 10"
        popularityLabel.text = "Popularity: \n\(viewModelMovie?.voteAverage ?? "0")"
        
        hStackView.addArrangedSubview(starImage)
        hStackView.addArrangedSubview(countVoteLabel)
        
        stackView.addArrangedSubview(hStackView)
        stackView.addArrangedSubview(popularityLabel)
        stackView.addArrangedSubview(realeaseDate)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
    }
    
}

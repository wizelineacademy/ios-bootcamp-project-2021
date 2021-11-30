//
//  DetailHeaderView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit
protocol DetailHeaderViewDelegate: AnyObject {
    func openReviews(_ detailHeaderView: DetailHeaderView, with movie: Movie)
}

final class DetailHeaderView: UICollectionReusableView {
    // MARK: - Properties
    static let reuseIdentifier =  String(describing: DetailHeaderView.self)
    weak var delegate: DetailHeaderViewDelegate?
    public var viewModel: MovieDetailViewModel? {
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
        label.text = MoviesSectionConst.recommendations
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let reviewsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(InterfaceConst.reviews, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    private let imageBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
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
        let height = frame.width * 0.6
        addSubview(headerLabel)
        headerLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        imageBackground.setHeight(height)
        
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
        guard let viewModel = viewModel else { return }
        imageBackground.setImageFromNetwork(withURL: viewModel.imageUrl)
        overviewLabel.text = viewModel.overview
        dateLabel.text = viewModel.date
        popularityLabel.text = viewModel.popularity
        votesLabel.text = viewModel.votes
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
        guard let viewModel = viewModel else {return}
        delegate?.openReviews(self, with: viewModel.movie)
    }
}

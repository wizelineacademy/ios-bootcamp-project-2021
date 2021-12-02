//
//  DetailHeaderView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit
protocol DetailHeaderViewDelegate: AnyObject {
    func openReviews(_ detailHeaderView: DetailHeaderView, with movie: Movie)
    func openCasts(_ detailHeaderView: DetailHeaderView, with movie: Movie)
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
        label.numberOfLines = InterfaceConst.initZeroNumberLineValue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let dateLabel = UILabel()
    
    private let votesLabel = UILabel()
    
    private let popularityLabel = UILabel()
    
    private  var stackTags = UIStackView()
    
    private  var stackButtons = UIStackView()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = MoviesSectionConst.recommendations
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.headerFontSize)
        return label
    }()
    
    private let reviewsButton = UIButton()
    
    private let castButton = UIButton()
    
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
        let height = frame.width * InterfaceConst.fractionHightLayoutSection
        addSubview(headerLabel)
        headerLabel.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: InterfaceConst.paddingDefault,
            paddingBottom: InterfaceConst.paddingDefault,
            paddingRight: InterfaceConst.paddingDefault
        )
        
        addSubview(imageBackground)
        imageBackground.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        imageBackground.setHeight(height)
        
        stackTags = UIStackView(arrangedSubviews: [dateLabel, votesLabel, popularityLabel])
        addSubview(stackTags)
        stackTags.anchor(
            top: imageBackground.bottomAnchor,
            left: leftAnchor, right: rightAnchor,
            paddingTop: InterfaceConst.paddingDefault,
            paddingLeft: InterfaceConst.paddingDefault,
            paddingRight: InterfaceConst.paddingDefault
        )
        stackTags.distribution = .equalSpacing
        stackTags.setHeight(InterfaceConst.heightTagsDetailView)
        
        configureLabelToTag(label: dateLabel)
        configureLabelToTag(label: votesLabel, colorBackground: .systemPurple)
        configureLabelToTag(label: popularityLabel, colorBackground: .systemGreen)
        
        configureButtons()
        configureOverviewLabel()
    }
    
    private func configureButtons() {
        configureButtonsToView(button: reviewsButton, title: InterfaceConst.reviews)
        reviewsButton.setHeight(InterfaceConst.heighReviewButton)
        reviewsButton.addTarget(self, action: #selector(handleReviewButton), for: .touchUpInside)
        
        configureButtonsToView(button: castButton, colorBackground: .blue, title: InterfaceConst.cast)
        castButton.setHeight(InterfaceConst.heighReviewButton)
        castButton.addTarget(self, action: #selector(handleCastButton), for: .touchUpInside)
        
        stackButtons = UIStackView(arrangedSubviews: [castButton, reviewsButton])
        stackButtons.axis = UIDevice.current.userInterfaceIdiom == .pad ? .horizontal : .vertical
        stackButtons.spacing = InterfaceConst.paddingDefault
        stackButtons.distribution = .fillEqually
        
        addSubview(stackButtons)
        stackButtons.anchor(
            left: leftAnchor,
            bottom: headerLabel.topAnchor,
            right: rightAnchor, paddingTop:
                InterfaceConst.paddingDefault,
            paddingLeft: InterfaceConst.paddingDefault,
            paddingBottom: InterfaceConst.paddingDefault,
            paddingRight: InterfaceConst.paddingDefault
        )
    }
    
    private func configureOverviewLabel() {
        addSubview(overviewLabel)
        overviewLabel.anchor(
            top: stackTags.bottomAnchor,
            left: leftAnchor,
            bottom: stackButtons.topAnchor,
            right: rightAnchor,
            paddingTop: InterfaceConst.paddingDefault,
            paddingLeft: InterfaceConst.paddingDefault,
            paddingBottom: InterfaceConst.paddingDefault,
            paddingRight: InterfaceConst.paddingDefault
        )
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
        label.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.fontSizeTag)
        label.layer.masksToBounds = true
        label.layer.borderColor = colorBackground.cgColor
        label.layer.borderWidth = InterfaceConst.borderWidthTag
    }
    
    private func configureButtonsToView(button: UIButton, colorBackground: UIColor = .systemBlue, title: String) {
        button.setTitle(title, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = InterfaceConst.defaultCornerRadius
        button.backgroundColor = colorBackground
        button.tintColor = .white
    }
    // MARK: - Actions
    
    @objc
    private func handleReviewButton() {
        guard let viewModel = viewModel else {return}
        delegate?.openReviews(self, with: viewModel.movie)
    }
    
    @objc
    private func handleCastButton() {
        guard let viewModel = viewModel else {return}
        delegate?.openCasts(self, with: viewModel.movie)
    }
}

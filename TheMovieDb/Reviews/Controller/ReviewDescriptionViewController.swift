//
//  ReviewDescriptionViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class ReviewDescriptionViewController: UIViewController {
    
    public var review: Review? {
        didSet {
            configure()
        }
    }
    
    private let descriptionReviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(descriptionReviewLabel)
        descriptionReviewLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)

    }
    
    private func configure() {
        guard let review = review else { return }
        navigationItem.title = review.authorDetail.username
        descriptionReviewLabel.text = review.content
    }
}

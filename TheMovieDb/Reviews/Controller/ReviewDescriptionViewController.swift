//
//  ReviewDescriptionViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class ReviewDescriptionViewController: UIViewController {
    
    // MARK: - Properties
    public var review: Review? {
        didSet {
            configure()
        }
    }
    
    private let descriptionReviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.isEditable = false
        textView.textContainerInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        return textView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(descriptionReviewTextView)
        descriptionReviewTextView.frame = view.frame

    }
    
    // MARK: - Helpers
    private func configure() {
        guard let review = review else { return }
        descriptionReviewTextView.text = review.content
    }
    
}


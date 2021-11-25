//
//  ReviewDetailView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

final class ReviewDetailView: UIViewController {

    // MARK: Properties
    var presenter: ReviewDetailPresenterProtocol?
    
    private var review: Review? {
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

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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

extension ReviewDetailView: ReviewDetailViewProtocol {
    func presenterPushDataView(receivedReview: Review) {
        review = receivedReview
    }
}

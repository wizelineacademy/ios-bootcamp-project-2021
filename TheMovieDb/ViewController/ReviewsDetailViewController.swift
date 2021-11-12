//
//  ReviewsDetailViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit

final class ReviewsDetailViewModel {
    
    var review: ReviewsDetails?
}

final class ReviewsDetailViewController: UIViewController {
    
    var viewModel: ReviewsDetailViewModel = .init()
    
    let reviewCompletedText = UITextView()
    let authorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAllViews()
        setupReviewCompletedText()
        setupAuthorLabel()
        setupUI()
    }
    
    private func addAllViews() {
        view.addSubview(reviewCompletedText)
        view.addSubview(authorLabel)
        view.backgroundColor = .white
    }
    
    private func setupReviewCompletedText() {
        reviewCompletedText.translatesAutoresizingMaskIntoConstraints = false
        reviewCompletedText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        reviewCompletedText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: reviewCompletedText.trailingAnchor, constant: 20).isActive = true
        reviewCompletedText.isEditable = false
        reviewCompletedText.font = .systemFont(ofSize: 15)
    }
    
    private func setupAuthorLabel() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.topAnchor.constraint(equalTo: reviewCompletedText.bottomAnchor, constant: 20).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        authorLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: 20).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        authorLabel.textAlignment = .center
        authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupUI() {
        reviewCompletedText.text = viewModel.review?.content
        authorLabel.text = "Author: \(viewModel.review?.author ?? "Unavailable")"
    }
}

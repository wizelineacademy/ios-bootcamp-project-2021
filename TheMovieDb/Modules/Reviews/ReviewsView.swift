//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

class ReviewsView: UICollectionViewController {

    // MARK: Properties
    var presenter: ReviewsPresenterProtocol?
    private var reviews = [Review]()
    
    // MARK: - LifeCycle
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureUI() {
        self.collectionView!.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.reusableIdentifier )
        navigationItem.title = "Reviews"
        collectionView.backgroundColor = .systemBackground
    }
}

extension ReviewsView: ReviewsViewProtocol {
    func showReviews(reviews: [Review]) {
        self.reviews = reviews
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: UICollectionViewDataSource
extension ReviewsView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reusableIdentifier, for: indexPath) as? ReviewCell else {
            return ReviewCell()
        }
        let review = reviews[indexPath.row]
        let viewModel = ReviewViewModel(review: review)
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReviewsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 20, height: 200)
    }
}

// MARK: - UICollectionViewControllerDelegate
extension ReviewsView {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        presenter?.showDetail(review: review)
    }
    
}

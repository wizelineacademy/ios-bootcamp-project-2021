//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

final class ReviewsView: UICollectionViewController, DisplayError, DisplayMessage {

    // MARK: Properties
    var presenter: ReviewsPresenterProtocol?
    private var viewModel = [ReviewViewModel]() // reviews = [Review]()
    
    // MARK: - LifeCycle
    init(layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
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
        navigationItem.title = InterfaceConst.reviews
        collectionView.backgroundColor = .systemBackground

    }
}

extension ReviewsView: ReviewsViewProtocol {
    func showMessageNoReviews(with message: String) {
        displayMessageLabel(with: message)
    }
    
    func showErrorMessage(withMessage error: String) {
        viewDisplayError(with: error)
    }
    
    func showReviews(reviewViewModel: [ReviewViewModel]) {
        self.viewModel = reviewViewModel
        self.collectionView.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource
extension ReviewsView {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.reusableIdentifier, for: indexPath) as? ReviewCell else {
            return ReviewCell()
        }
        let viewModel = viewModel[indexPath.row]
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
        let review = viewModel[indexPath.row].review
        presenter?.showDetail(review: review)
    }
    
}

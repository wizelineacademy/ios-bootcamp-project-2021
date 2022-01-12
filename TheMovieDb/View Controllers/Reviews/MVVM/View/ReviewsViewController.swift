//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import UIKit

class ReviewsViewController: UIViewController, ReviewViewProtocol {
    var viewModel: ReviewListVideModelProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        guard let movie = self.viewModel?.movie else { return }
        fetchReviewsWith(movie: movie)
        didFetch()
    }
    
    func setUpView() {
        self.title = self.viewModel?.getScreenTitle()
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieReviews()
        collectionView.setup(dataSource: self)
        collectionView.registerNibForCellWith(name: ReviewCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
    }
    
    func fetchReviewsWith(movie: MovieProtocol) {
        viewModel?.fetchReviewsOfMovie(id: movie.id.description)
    }
    
    func didFetch() {
        viewModel?.didFetchReviews = { [weak self] reviewsViewModelList in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
   
}

extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel?.reviews.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifierToDeque, for: indexPath) as? ReviewCollectionViewCell, let viewModel = self.viewModel?.reviews.results[indexPath.row] {
            cell.setInfoWith(viewModel: viewModel)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

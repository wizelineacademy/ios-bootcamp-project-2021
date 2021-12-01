//
//  ReviewsViewController.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import UIKit

class ReviewsViewController: UIViewController, ReviewViewProtocol {
    var viewModel: ReviewListVideModelProtocol?
    let dataSource = ReviewsDataSource()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        guard let movie = self.viewModel?.movie else { return }
        fetchReviewsWith(movie: movie)
        didFetch()
    }
    
    func setUpView() {
        self.title = "Reviews"
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieReviews()
        collectionView.setup(dataSource: dataSource)
        collectionView.registerNibForCellWith(name: ReviewCollectionViewCell.identifierToDeque)
        collectionView.reloadData()
    }
    
    func fetchReviewsWith(movie: MovieProtocol) {
        viewModel?.fetchReviewsOfMovie(id: movie.id.description)
    }
    
    func didFetch() {
        viewModel?.didFetchReviews = { [weak self] reviewsViewModelList in
            print(reviewsViewModelList)
            self?.dataSource.reviewsViewModelList = reviewsViewModelList
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
   
}

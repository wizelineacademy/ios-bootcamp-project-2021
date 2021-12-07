//
//  DetailSceneViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 23/11/21.
//

import UIKit
import Combine

protocol DetailSceneViewControllerInput: AnyObject {
    func showMovieDetails(reviews: [ReviewModel], recommendations: [MovieModel])
    func showErrorMessage(message: String)
}

protocol DetailSceneViewControllerOutput: AnyObject {
    func callToDetailServices(reviewRequest: ReviewRequest,
                              recommendationRequest: RecommendationsRequest)
}

final class DetailSceneViewController: UICollectionViewController {
    
    // MARK: Properties
    var interactor: DetailSceneInteractorInput?
    var router: DetailSceneRoutingLogic?
    private let movie: MovieModel
    private lazy var dataSource: DetailDataSource = {
        return DetailDataSource(item: movie, delegate: self)
    }()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(movie: MovieModel) {
        self.movie = movie
        let identifier = String(describing: DetailSceneViewController.self)
        super.init(nibName: identifier, bundle: Bundle.main)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DetailHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DetailHeaderView.identifier)
        collectionView.register(DetailRatingCell.self,
                                forCellWithReuseIdentifier: DetailRatingCell.identifier)
        collectionView.register(DetailOverviewCell.self,
                                forCellWithReuseIdentifier: DetailOverviewCell.identifier)
        collectionView.register(DetailReviewsCell.self,
                                forCellWithReuseIdentifier: DetailReviewsCell.identifier)
        collectionView.register(DetailRecommendationsCell.self,
                                forCellWithReuseIdentifier: DetailRecommendationsCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = DetailFlowLayout(dataSource: dataSource)
        interactor?.callToDetailServices(reviewRequest: ReviewRequest(id: movie.id ?? 0),
                                         recommendationRequest: RecommendationsRequest(id: movie.id ?? 0))
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView
            .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                              withReuseIdentifier: DetailHeaderView.identifier,
                                              for: indexPath) as? DetailHeaderView else {
                return UICollectionReusableView()
            }
        header.movie = movie
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath) {
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.items.count
    }
}

extension DetailSceneViewController: DetailSceneViewControllerInput {
    
    func showMovieDetails(reviews: [ReviewModel], recommendations: [MovieModel]) {
        dataSource.appendReviewItems(reviews: reviews)
        dataSource.appendRecommendationItems(recomendations: recommendations)
        collectionView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        router?.showToast(message: message)
    }
}

extension DetailSceneViewController: DetailReviewsCellDelegate {
    func didSelectReview(_ review: ReviewModel?) {
        guard let review = review else {
            return
        }
        router?.showReviewDetail(review: review)
    }
}

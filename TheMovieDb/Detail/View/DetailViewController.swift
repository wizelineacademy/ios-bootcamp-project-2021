//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 04/11/21.
//

import UIKit

final class DetailViewController: UICollectionViewController {
    
    private let movie: MovieModel
    private let dataSource: DetailDataSource
    private var reviews: [ReviewModel] = []
    private var recommendations: [MovieModel] = []
    private let executor: ExecutorRequest
    private let group = DispatchGroup()
    
    init?(movie: MovieModel,
          executor: ExecutorRequest = NetworkAPI(),
          coder: NSCoder) {
        self.movie = movie
        self.executor = executor
        dataSource = DetailDataSource(item: movie)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = DetailFlowLayout(dataSource: dataSource)
        callReviewsService()
        callRecommendationsService()
        group.notify(queue: DispatchQueue.main) {
            self.dataSource.appendReviewItems(reviews: self.reviews)
            self.dataSource.appendRecommendationItems(recomendations: self.recommendations)
            self.collectionView.reloadData()
        }
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

private extension DetailViewController {
    
    func callReviewsService() {
        guard let id = movie.id else { return }
        group.enter()
        executor
            .execute(request: ReviewRequest(id: id),
                     onSuccess: { [weak self] (reviews: PageModel<ReviewModel>?) in
                self?.reviews = reviews?.results ?? []
                self?.group.leave()
            }, onError: { [weak self] error in
                self?.group.leave()
            })
    }
    
    func callRecommendationsService() {
        guard let id = movie.id else { return }
        group.enter()
        executor
            .execute(request: RecommendationsRequest(id: id),
                     onSuccess: { [weak self] (recommendations: PageModel<MovieModel>?) in
                self?.recommendations = recommendations?.results ?? []
                self?.group.leave()
            }, onError: { [weak self] error in
                self?.group.leave()
            })
    }
}

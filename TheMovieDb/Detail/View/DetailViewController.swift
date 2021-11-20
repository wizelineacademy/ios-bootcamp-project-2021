//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 04/11/21.
//

import UIKit
import Combine

final class DetailViewController: UICollectionViewController {
    
    // MARK: Properties
    private let movie: MovieModel
    private let dataSource: DetailDataSource
    private var reviews: [ReviewModel] = []
    private var recommendations: [MovieModel] = []
    private let executor: ExecutorRequest
    private let group = DispatchGroup()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
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
        callServices()
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
    
    func callServices() {
        guard let id = movie.id else { return }
        Publishers.Zip(
            executor.execute(request: ReviewRequest(id: id)),
            executor.execute(request: RecommendationsRequest(id: id))
        ).receive(on: DispatchQueue.main)
            .sink { (reviews: PageModel<ReviewModel>?, recommendations: PageModel<MovieModel>?) in
            self.dataSource.appendReviewItems(reviews: reviews?.results ?? [])
            self.dataSource.appendRecommendationItems(recomendations: recommendations?.results ?? [])
            self.collectionView.reloadData()
        }.store(in: &cancellables)
        
    }
}

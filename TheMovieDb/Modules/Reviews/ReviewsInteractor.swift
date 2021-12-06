//
//  ReviewsInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Combine

final class ReviewsInteractor: ReviewsInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: ReviewsInteractorOutputProtocol?
    private var reviewsWorker: ReviewsWorkerProtocol?
    private var cancellable = Set<AnyCancellable>()
    private let movie: Movie
 
    init(movie: Movie, reviewWorker: ReviewsWorkerProtocol) {
        self.movie = movie
        self.reviewsWorker = reviewWorker
    }
    
    func getReviews() {
        reviewsWorker?.fetchReviews(with: movie)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    self.presenter?.onError(errorMessage: error.localizedDescription)
                }
            }, receiveValue: { [unowned self] (reviewsData: Reviews) in
                let reviews = reviewsData.reviews
                let viewModel = reviews.map { ReviewViewModel(review: $0) }
                if viewModel.count > 0 {
                    self.presenter?.reviewsFromInteractor(reviewViewModel: viewModel)
                } else {
                    self.presenter?.noReviews(with: InterfaceConst.noReviews)
                }
               
            }).store(in: &cancellable)

    }
    
}

//
//  DetailSceneWorker.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 21/11/21.
//

import Foundation
import Combine

protocol DetailSceneLogic {
    func callDetailServices(reviewRequest: ReviewRequest,
                            recommendationRequest: RecommendationsRequest,
                            completion: @escaping ([ReviewModel], [MovieModel]) -> Void)
}

final class DetailSceneWorker {
    private let service: ExecutorRequest
    private var bag = Set<AnyCancellable>()
    
    init(service: ExecutorRequest = NetworkAPI()) {
        self.service = service
    }
}

extension DetailSceneWorker: DetailSceneLogic {
    func callDetailServices(reviewRequest: ReviewRequest,
                            recommendationRequest: RecommendationsRequest,
                            completion: @escaping ([ReviewModel], [MovieModel]) -> Void) {
        Publishers.Zip(
            service.execute(request: reviewRequest),
            service.execute(request: recommendationRequest)
        ).receive(on: DispatchQueue.main)
            .sink { (reviewsPage: PageModel<ReviewModel>?, recommendationsPage: PageModel<MovieModel>?) in
                let reviews = reviewsPage?.results ?? []
                let recommendations = recommendationsPage?.results ?? []
                completion(reviews, recommendations)
            }.store(in: &bag)
    }
}

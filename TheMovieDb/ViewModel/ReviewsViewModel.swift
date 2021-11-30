//
//  ReviewsViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import Combine
import os.log

final class ReviewsViewModel: ObservableObject {
    private var movieID: Int?
    private var facade: MovieService
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var reviews: [ReviewsDetails] = []
    @Published var activeError: MovieError?

    init(id: Int, facade: MovieService) {
        self.movieID = id
        self.facade = facade
        os_log("ReviewsViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    func reviewsMovie() {
        guard let id = movieID else { return }
        facade.get(type: MovieResponse<ReviewsDetails>.self, search: nil, endpoint: .reviews(id: id))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.activeError = error
                    os_log("ReviewsViewModel failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { reviewsResponse in
                guard let reviews = reviewsResponse.results,
                      !reviews.isEmpty else {
                          self.activeError = .emptyResponse(list: "reviews.title.bar.button".localized)
                          return
                      }
                self.reviews = reviews
            })
            .store(in: &subscriptions)
    }
}

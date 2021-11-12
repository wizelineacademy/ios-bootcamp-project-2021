//
//  ReviewsViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation

final class ReviewsViewModel {
    var movieID: Int?
    var movie: Movie?
    var reviews: [ReviewsDetails] = []
    var showError: ((MovieError) -> Void)?
    var facade: MovieService
    init(facade: MovieService) {
        self.facade = facade
    }
    var reloadData: (() -> Void)?
    
    func reviewsMovie() {
        guard let id = movieID else { return }
        facade.get(search: nil, endpoint: .reviews(id: id)) { [weak self] (response: Result<MovieResponse<ReviewsDetails>, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let reviewsResponse):
                self.reviews = reviewsResponse.results ?? []
                DispatchQueue.main.async {
                    self.reloadData?()
                }
            case .failure(let failureResult):
                self.showError?(failureResult)
            }
        }
    }
}

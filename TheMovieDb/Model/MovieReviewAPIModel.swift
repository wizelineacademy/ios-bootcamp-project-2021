//
//  MovieReviewAPIModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation

struct MovieReviewAPIModel {
    let movieApiManager: MovieAPIManager

    init(movieApiManager: MovieAPIManager) {
        self.movieApiManager = movieApiManager
    }

    func getReviews(movieFeed: MovieFeed, searchId: String, completion: @escaping (([MovieReviewViewModel]) -> Void)) {
        var reviews: [MovieReviewViewModel] = []
        let group = DispatchGroup()

        group.enter()
        movieApiManager.getFeed(from: .reviews, searchId: searchId) { (result: Result<MovieReviewResult?, APIError) in
            switch result {
            case .success(let results):
                guard let results = results else {
                    group.leave()
                    return
                }
                let mappedValues
            }
        }
    }
}

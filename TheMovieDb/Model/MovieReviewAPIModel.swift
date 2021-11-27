//
//  MovieReviewAPIModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation
import os

struct MovieReviewAPIModel {
    private static let logger = Logger(subsystem: Constants.subsystemName, category: "MovieReviewAPIModel")
    let movieApiManager: MovieAPIManager
    
    init(movieApiManager: MovieAPIManager) {
        self.movieApiManager = movieApiManager
    }
    
    func getReviews(imageBaseURL: String, searchId: String, completion: @escaping (([MovieReviewViewModel]) -> Void)) {
        var reviews: [MovieReviewViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        movieApiManager.getFeed(from: .reviews, searchId: searchId) { (result: Result<MovieReviewResult?, APIError>) in
            switch result {
            case .success(let results):
                guard let results = results else {
                    group.leave()
                    return
                }
                let mappedValues = results.results?.map({
                    return MovieReviewViewModel(movieReview: $0, avatarBaseURL: imageBaseURL)
                }) ?? []
                reviews.append(contentsOf: mappedValues)
                group.leave()
            case .failure(let error):
                Self.logger.error("\(error.localizedDescription)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(reviews)
        }
    }
}

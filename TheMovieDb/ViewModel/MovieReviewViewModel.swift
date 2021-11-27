//
//  MovieReviewViewModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation

struct MovieReviewViewModel {
    let content: String
    let createdAt: String
    let userName: String
    let avatarPath: String
    let baseURL: String

    init(movieReview: MovieReviewItem, configuration: ConfigurationImage) {
        self.content = movieReview.content
        self.createdAt = movieReview.createdAt
        self.userName = movieReview.authorDetails.username
        self.avatarPath = movieReview.authorDetails.avatarPath
        self.baseURL = configuration.getSecureBasePosterURL()
    }

    lazy var avatarURL: URL? = {
        return URL(string: baseURL + avatarPath)
    }()
}

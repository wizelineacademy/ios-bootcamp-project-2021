//
//  MovieReviewViewModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation

struct MovieReviewViewModel {
    let id: String
    let content: String
    let createdAt: String
    let userName: String
    let avatarPath: String
    let avatarBaseURL: String

    init(movieReview: MovieReviewItem, avatarBaseURL: String) {
        self.id = movieReview.id ?? UUID().uuidString
        self.content = movieReview.content ?? ""
        self.createdAt = movieReview.createdAt ?? ""
        self.userName = movieReview.authorDetails?.username ?? ""
        self.avatarPath = movieReview.authorDetails?.avatarPath ?? ""
        self.avatarBaseURL = avatarBaseURL
    }

    func getAvatarURL() -> URL? {
        if avatarPath.contains("https") {
            print(avatarPath)
            return URL(string: avatarPath)
        }
        print(avatarBaseURL + avatarPath)
        return URL(string: avatarBaseURL + avatarPath)
    }
}

extension MovieReviewViewModel {
    static let preview = MovieReviewViewModel(
        movieReview: MovieReviewItem.preview,
        avatarBaseURL: "http://image.tmdb.org/t/p/")
}

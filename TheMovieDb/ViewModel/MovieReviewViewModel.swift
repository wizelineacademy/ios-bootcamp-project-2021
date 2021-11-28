//
//  MovieReviewViewModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import Foundation
import os

struct MovieReviewViewModel {
    private static let logger = Logger(subsystem: Constants.subsystemName, category: "MovieReviewViewModel")
    
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
        guard !avatarPath.isEmpty else {
            return nil
        }
        if avatarPath.contains("https"), let range = avatarPath.range(of: "https") {
            // Se corta a partir del https, ya que en algunas ocasiones la URL
            // de la imagen es algo como /https://secure.gravatar.com/avatar/992eef352126a53d7e141bf9e8707576.jpg
            let url = avatarPath[range.lowerBound...]
            Self.logger.debug("Trying to get image \(url)")
            return URL(string: String(url))
        }
        let url = avatarBaseURL + avatarPath
        Self.logger.debug("Trying to get image \(url)")
        return URL(string: url)
    }
}

extension MovieReviewViewModel {
    static let preview = MovieReviewViewModel(
        movieReview: MovieReviewItem.preview,
        avatarBaseURL: "http://image.tmdb.org/t/p/")
}

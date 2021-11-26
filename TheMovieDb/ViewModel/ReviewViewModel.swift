//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 24/11/21.
//

import Foundation

struct ReviewViewModel: Hashable {
   
    let author: String
    let content: String
    let created: String
    let rating: Double
    let imageAvatar: URL?
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: ReviewViewModel, rhs: ReviewViewModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
}

extension ReviewViewModel {
    init(review: Review) {
        
        self.author = review.author
        self.content = review.content
        self.created = review.createdAt
        self.rating = review.authorDetails.rating ?? 0
        
        if let portraitPhotoURL = review.authorDetails.avatarPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(portraitPhotoURL)") {
            self.imageAvatar = url
        } else {
            self.imageAvatar = nil
        }
    }
}

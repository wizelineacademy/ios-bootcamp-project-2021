//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 24/11/21.
//

import Foundation

struct ReviewViewModel: Hashable, Identifiable {
    var id: String
    let author: String
    let content: String
    let created: String
    let rating: String
    
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
        self.id = review.id
        self.author = review.author
        self.content = review.content
        self.created = review.createdAt
        self.rating = String(review.authorDetails.rating ?? 0)
    }
}

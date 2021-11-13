//
//  DetailSection.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 05/11/21.
//

import Foundation

struct MovieRatingModel: Hashable {
    var rating: Float?
    var popularity: Float?
    var voteCount: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(rating)
        hasher.combine(popularity)
        hasher.combine(voteCount)
    }
    
    static func == (lhs: MovieRatingModel, rhs: MovieRatingModel) -> Bool {
        return lhs.rating == rhs.rating &&
            lhs.popularity == rhs.popularity &&
            lhs.voteCount == rhs.voteCount
    }
}

struct MovieOverviewModel: Hashable {
    var title: String?
    var overview: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(overview)
    }
    
    static func == (lhs: MovieOverviewModel, rhs: MovieOverviewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.overview == rhs.overview
    }
}

struct MovieReviewsModel: Hashable {
    var id: Int
    var title: String
    var reviews: [ReviewModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(reviews)
    }
    
    static func == (lhs: MovieReviewsModel, rhs: MovieReviewsModel) -> Bool {
        return lhs.id == rhs.id && lhs.reviews == rhs.reviews && lhs.title == rhs.title
    }
}

struct MovieRecommendationsModel: Hashable {
    var id: Int
    var title: String
    var recommendations: [MovieModel]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(recommendations)
    }
    
    static func == (lhs: MovieRecommendationsModel, rhs: MovieRecommendationsModel) -> Bool {
        return lhs.id == rhs.id && lhs.recommendations == rhs.recommendations && lhs.title == rhs.title
    }
}

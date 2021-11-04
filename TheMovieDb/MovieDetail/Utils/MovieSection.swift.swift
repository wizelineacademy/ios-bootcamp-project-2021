//
//  MovieSection.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

enum RelatedMovieSections: Int, CaseIterable {
    case recommendations
    case similar

    var description: String {
        switch self {
        case .recommendations: return "Recommendations"
        case .similar: return "Similar"
        }
    }
    
    var path: APIEndPoints {
        switch self {
        case .recommendations: return .recommendations
        case .similar: return .similar
        }
    }
}

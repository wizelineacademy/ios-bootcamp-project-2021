//
//  MovieSection.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

enum RelatedMovieSections: Int {
    case recommendations
    case similar

    var description: String {
        switch self {
        case .recommendations: return "Recommendations"
        case .similar: return "Similar"
        }
    }
}

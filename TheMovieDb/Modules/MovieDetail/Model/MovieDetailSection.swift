//
//  MovieDetailSection.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//

import Foundation

enum MovieDetailSections: Int, CaseIterable {
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

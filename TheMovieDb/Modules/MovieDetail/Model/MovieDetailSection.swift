//
//  MovieDetailSection.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//

import Foundation
import UIKit

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
    
    var sizeCell: CGFloat {
        switch self {
        case .recommendations: return  500
        case .similar: return 50
        }
    }
    
    var header: UICollectionReusableView {
        switch self {
        case .recommendations: return DetailHeaderView()
        case .similar: return DetailHeader()
        }
    }
}

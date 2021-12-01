//
//  ReviewsViewModelList.swift
//  TheMovieDb
//
//  Created by developer on 01/12/21.
//

import Foundation

struct ReviewsViewModelList: ReviwsViewModelListProtocol {
    typealias ReviewsTypes = ReviewViewModel
    var results: [ReviewViewModel]
}

//
//  ReviewViewModel.swift
//  TheMovieDb
//
//  Created by developer on 01/12/21.
//

import Foundation

struct ReviewViewModel: ReviewViewModelProtocol {
    var review: ReviewProtocol
    
    func formatReviewText() -> NSAttributedString {
        return AttributedTextCreator.textForMovieDetailInfo(review: review)
    }
}

//
//  ReviewsWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

final class ReviewsRouter: ReviewsRouterProtocol {
    
    func showReviewDetail(from view: ReviewsViewProtocol, with review: Review) {
        let reviewDetail = ReviewDetailBuilder.createModule(with: review)
        guard let view = view as? ReviewsView else { return }
        view.navigationController?.pushViewController(reviewDetail, animated: true)
    }
}

//
//  DetailSceneRouter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 21/11/21.
//

import Foundation
import UIKit
import SwiftUI

protocol DetailSceneRoutingLogic {
    
    func showToast(message: String)
    func showReviewDetail(review: ReviewModel)
}

final class DetailSceneRouter {
    
    weak var source: UIViewController?
}

extension DetailSceneRouter: DetailSceneRoutingLogic {
    
    func showToast(message: String) {
        Toast.showToast(title: message)
    }
    
    func showReviewDetail(review: ReviewModel) {
        let rating: Float = Float(review.authorDetails?.rating ?? 0.0)
        let reviewView = ReviewSceneView(review: review, valueRating: rating)
        reviewView.valueRating = rating
        let hostingViewController = UIHostingController(rootView: reviewView)
        source?.present(hostingViewController, animated: true)
    }
}

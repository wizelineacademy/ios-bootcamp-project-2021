//
//  ReviewDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

final class ReviewDetailWireFrame: ReviewDetailWireFrameProtocol {

    static func createReviewDetailModule(with review: Review) -> UIViewController {
        let view = ReviewDetailView()
        
        let presenter: ReviewDetailPresenterProtocol = ReviewDetailPresenter()
        let wireFrame: ReviewDetailWireFrameProtocol = ReviewDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.setReview(settedReview: review)
        
        return view
        
    }

}

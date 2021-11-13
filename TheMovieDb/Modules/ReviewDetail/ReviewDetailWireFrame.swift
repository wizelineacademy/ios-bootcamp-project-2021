//
//  ReviewDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

class ReviewDetailWireFrame: ReviewDetailWireFrameProtocol {

    class func createReviewDetailModule(with review: Review) -> UIViewController {
        let view = ReviewDetailView()
        
        let presenter: ReviewDetailPresenterProtocol & ReviewDetailInteractorOutputProtocol = ReviewDetailPresenter()
        let interactor: ReviewDetailInteractorInputProtocol = ReviewDetailInteractor()
        let wireFrame: ReviewDetailWireFrameProtocol = ReviewDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.setReview(settedReview: review)
        
        return view
        
    }

}

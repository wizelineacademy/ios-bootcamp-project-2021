//
//  ReviewsWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

class ReviewsWireFrame: ReviewsWireFrameProtocol {
    
    class func createReviewsModule(movie: Movie) -> UIViewController {
        let view = ReviewsView()
        let presenter: ReviewsPresenterProtocol & ReviewsInteractorOutputProtocol = ReviewsPresenter()
        let interactor: ReviewsInteractorInputProtocol & ReviewsRemoteDataManagerOutputProtocol = ReviewsInteractor()
        let remoteDataManager: ReviewsRemoteDataManagerInputProtocol = ReviewsRemoteDataManager()
        let wireFrame: ReviewsWireFrameProtocol = ReviewsWireFrame()
        
        view.presenter = presenter
        //
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        presenter.setMovie(movie)
        //
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    func showReviewDetail(from view: ReviewsViewProtocol, with review: Review) {
        let reviewDetail = ReviewDetailWireFrame.createReviewDetailModule(with: review)
        guard let view = view as? ReviewsView else { return }
        view.navigationController?.pushViewController(reviewDetail, animated: true)
    }
}

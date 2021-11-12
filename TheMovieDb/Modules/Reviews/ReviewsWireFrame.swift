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
    
    class func createReviewsModule() -> UIViewController {
        let view = ReviewsView()
        let presenter: ReviewsPresenterProtocol & ReviewsInteractorOutputProtocol = ReviewsPresenter()
        let interactor: ReviewsInteractorInputProtocol & ReviewsRemoteDataManagerOutputProtocol = ReviewsInteractor()
        let localDataManager: ReviewsLocalDataManagerInputProtocol = ReviewsLocalDataManager()
        let remoteDataManager: ReviewsRemoteDataManagerInputProtocol = ReviewsRemoteDataManager()
        let wireFrame: ReviewsWireFrameProtocol = ReviewsWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }

}

//
//  ReviewDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import UIKit.UIViewController

enum ReviewDetailBuilder: ReviewDetailBuilderProtocol {

    static func createModule(with review: Review) -> UIViewController {
        let view = ReviewDetailView()
        let presenter: ReviewDetailPresenterProtocol & ReviewDetailInteractorOutputProtocol = ReviewDetailPresenter()
        let interactor: ReviewDetailInteractorInputProtocol = ReviewDetailInteractor(review: review)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        
        interactor.presenter = presenter
    
        return view
    }

}

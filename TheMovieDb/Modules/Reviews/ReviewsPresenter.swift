//
//  ReviewsPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

class ReviewsPresenter {
    
    // MARK: Properties
    weak var view: ReviewsViewProtocol?
    var interactor: ReviewsInteractorInputProtocol?
    var wireFrame: ReviewsWireFrameProtocol?
    
}

extension ReviewsPresenter: ReviewsPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension ReviewsPresenter: ReviewsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}

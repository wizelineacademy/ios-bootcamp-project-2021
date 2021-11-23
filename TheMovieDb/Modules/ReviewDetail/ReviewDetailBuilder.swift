//
//  ReviewDetailWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import UIKit.UIViewController
import SwiftUI

enum ReviewDetailBuilder: ReviewDetailBuilderProtocol {

    static func createModule(with review: Review) -> UIViewController {
        
        let interactor = ReviewDetailInteractor(review: review)
        let presenter = ReviewDetailPresenter(interactor: interactor)
        let view = ReviewDetailViewUI(presenter: presenter)
        let viewUI = UIHostingController(rootView: view)

        return viewUI
    }

}

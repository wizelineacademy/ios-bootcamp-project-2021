//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import UIKit

class ReviewsView: UIViewController {

    // MARK: Properties
    var presenter: ReviewsPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ReviewsView: ReviewsViewProtocol {
    // TODO: implement view output methods
}

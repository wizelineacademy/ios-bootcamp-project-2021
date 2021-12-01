//
//  ReviewsViewBuilder.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import Foundation
import UIKit

struct ReviewsViewBuilder: ReviewsViewBuilderProtocol {
    static func buildModuleWith(movie: MovieProtocol) -> UIViewController? {
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        guard let reviewsViewController = storyboad.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController else { return nil}
        let dataApiManager = ReviewsAPIDataManager()
        let viewModel = ReviewListViewModel(review: ReviewsViewModelList(results: []), apiDataManager: dataApiManager, movie: movie)
        reviewsViewController.viewModel = viewModel
        return reviewsViewController
    }
    
}

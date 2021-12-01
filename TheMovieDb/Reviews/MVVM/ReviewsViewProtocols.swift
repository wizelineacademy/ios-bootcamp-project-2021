//
//  ReviewsViewProtocols.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import Foundation
import UIKit

protocol ReviewListVideModelProtocol {
    var movie: MovieProtocol { get set }
    var reviews: ReviewsViewModelList { get set }
    var apiDataManager: ReviewsAPIDataManagerProtocol { get set }
    func fetchReviewsOfMovie(id: String)
    var didFetchReviews: ((_ results: ReviewsViewModelList) -> Void)? { get set }
}

protocol ReviewsAPIDataManagerProtocol {
    func requestReviews<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void )
}

protocol ReviewsViewBuilderProtocol {
    static func buildModuleWith(movie: MovieProtocol) -> UIViewController? 
}

protocol ReviewViewProtocol {
    var viewModel: ReviewListVideModelProtocol? { get set }
    func fetchReviewsWith(movie: MovieProtocol)
}

protocol ReviwsListProtocol {
    associatedtype ReviewsTypes
    var results: [ReviewsTypes] { get set }
}

protocol ReviwsViewModelListProtocol {
    associatedtype ReviewsTypes
    var results: [ReviewsTypes] { get set }
}

protocol ReviewViewModelProtocol {
    var review: ReviewProtocol { get set }
    func formatReviewText() -> NSAttributedString
}

protocol ReviewProtocol {
    var id: String? { get set }
    var author: String { get set }
    var content: String { get set }
    
}

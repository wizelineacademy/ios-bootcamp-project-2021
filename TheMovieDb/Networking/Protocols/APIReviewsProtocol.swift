//
//  APIReviewsProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

typealias reviewsCompletion = (Result<Reviews, Error>) -> Void

protocol APIReviewsProtocol: AnyObject {
    func getReviews(with parameters: APIParameters, completion: @escaping(reviewsCompletion))
}

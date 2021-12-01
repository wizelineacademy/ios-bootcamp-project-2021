//
//  ReviewsAPIDataManager.swift
//  TheMovieDb
//
//  Created by developer on 30/11/21.
//

import Foundation

final class ReviewsAPIDataManager: ReviewsAPIDataManagerProtocol {
    
    func requestReviews<T: Decodable>(value: T.Type, request: Request, completion: @escaping (Result< T?, Error>) -> Void ) {
        
        MovieDbAPI.request(value: T.self, request: request) {  result in
            switch result {
            case .success(let result):
                guard let listOfReviews = result else { return }
                completion(.success(listOfReviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

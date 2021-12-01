//
//  ReviewsRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import Combine

struct ReviewsWorker: ReviewsWorkerProtocol {

    private let service: APIMoviesProtocol
    init(service: APIMoviesProtocol = APIService()) {
        self.service = service
    }
    
    func fetchReviews(with movie: Movie) -> AnyPublisher<Reviews, APIRequestError> {
        let id = String(movie.id)
        let parameter = APIParameters(id: id)
        return service.fetchData(endPoint: .review, with: parameter).eraseToAnyPublisher()
    }

}

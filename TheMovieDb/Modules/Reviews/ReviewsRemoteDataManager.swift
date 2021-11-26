//
//  ReviewsRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import Combine

final class ReviewsRemoteDataManager: ReviewsRemoteDataManagerInputProtocol {

    var remoteRequestHandler: ReviewsRemoteDataManagerOutputProtocol?
    private let service: APIMoviesProtocol
    private var cancellable = Set<AnyCancellable>()
    init(service: APIMoviesProtocol) {
        self.service = service
    }
    
    func fetchReviews(movie: Movie) {
        let id = String(movie.id)
        let parameter = APIParameters(id: id)
        service.fetchData(endPoint: .review, with: parameter)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { (reviews: Reviews) in
                self.remoteRequestHandler?.reviewsFromServer(reviewsData: reviews)
            }).store(in: &cancellable)
        
    }

}

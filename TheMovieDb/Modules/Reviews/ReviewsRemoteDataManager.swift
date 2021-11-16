//
//  ReviewsRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation

final class ReviewsRemoteDataManager: ReviewsRemoteDataManagerInputProtocol {

    var remoteRequestHandler: ReviewsRemoteDataManagerOutputProtocol?
    
    func fetchReviews(movie: Movie) {
        let id = String(movie.id)
        let parameter = APIParameters(id: id)
        MovieAPI.shared.fetchData(endPoint: .review, with: parameter, completion: {(response: Result<Reviews, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let reviews):
                
                self.remoteRequestHandler?.reviewsFromServer(reviewsData: reviews)
            }
       
        })
    }

}

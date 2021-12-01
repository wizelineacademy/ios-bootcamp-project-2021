//
//  CastWorker.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Foundation
import Combine

struct CastWorker: CastWorkerProtocol {

    private let service: APIMoviesProtocol
    init(service: APIMoviesProtocol = APIService()) {
        self.service = service
    }
    
    func fetchCredits(with movie: Movie) -> AnyPublisher<CreditsMovie, APIRequestError> {
        let id = String(movie.id)
        let parameter = APIParameters(id: id)
        return service.fetchData(endPoint: .credits, with: parameter).eraseToAnyPublisher()
    }

}

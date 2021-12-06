//
//  MovieDetailRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Combine

protocol MoviesWorkerProtocol {
    func fetchMovies(endPoint: APIEndPoints, with paremeters: APIParameters) -> AnyPublisher<Movies, APIRequestError>
}

struct MoviesWorker: MoviesWorkerProtocol {
    
    private let service: APIMoviesProtocol
    private var cancellable: AnyCancellable?
    
    init(service: APIMoviesProtocol = APIService()) {
        self.service = service
    }
    
    func fetchMovies(endPoint: APIEndPoints, with paremeters: APIParameters = APIParameters()) ->  AnyPublisher<Movies, APIRequestError> {
        return service.fetchData(endPoint: endPoint, with: paremeters).eraseToAnyPublisher()
    }
    
}

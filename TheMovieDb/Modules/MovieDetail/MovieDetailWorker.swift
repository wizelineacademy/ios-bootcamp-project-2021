//
//  MovieDetailRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Combine

struct MovieDetailWorker: MovieDetailWorkerProtocol {
    
    private let service: APIMoviesProtocol
    private var cancellable: AnyCancellable?
    
    init(service: APIMoviesProtocol = APIService()) {
        self.service = service
    }
    
    func fetchMovies(typeMovieSection: MovieDetailSections, with paremeters: APIParameters = APIParameters()) ->  AnyPublisher<Movies, APIRequestError> {
        return service.fetchData(endPoint: typeMovieSection.path, with: paremeters).eraseToAnyPublisher()
    }
    
}

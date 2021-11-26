//
//  MovieDetailRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import Combine

class MovieDetailRemoteDataManager: MovieDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    private let group = DispatchGroup()
    private let defaultParameters = APIParameters()
    var movies: [MovieDetailSections: [Movie]] = [:]
    private let service: APIMoviesProtocol
    private var cancellable: AnyCancellable?
    
    init(service: APIMoviesProtocol) {
        self.service = service
    }
    
    func fetchRelatedMovies() {
        self.cancellable = Publishers.Zip(
            fetchData(typeMovieSection: .recommendations), fetchData(typeMovieSection: .similar)
        )
            .sink(receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { (recommendations: Movies, similar: Movies) in
                self.movies[.recommendations] = recommendations.movies
                self.movies[.similar] = similar.movies
                self.remoteRequestHandler?.relatedMoviesFound(self.movies)
            })
        
    }
    
    private func fetchData<T: Decodable>(typeMovieSection: MovieDetailSections) ->  AnyPublisher<T, APIRequestError> {
        return service.fetchData(endPoint: typeMovieSection.path, with: defaultParameters)
    }
    
}

//
//  SearchingRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import Combine

final class SearchingRemoteDataManager: SearchingRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchingRemoteDataManagerOutputProtocol?
    private var cancellables = Set<AnyCancellable>()
    private let service: APIMoviesProtocol
    
    init(service: APIMoviesProtocol) {
        self.service = service
    }
    
    func fetchMovies(_ searchText: String) {
        let parameters = APIParameters(query: searchText)
        service.fetchDataCombine(endPoint: .search, with: parameters)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    print(error.localizedDescription)
                }
            }, receiveValue: { (movies: Movies) in
                self.remoteRequestHandler?.moviesFound(found: movies)
            }).store(in: &cancellables)
        
    }
}

//
//  SearchingRemoteDataManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

final class SearchingRemoteDataManager: SearchingRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchingRemoteDataManagerOutputProtocol?
    var service: APIMoviesProtocol?
    
    func fetchMovies(_ searchText: String) {
        let parameters = APIParameters(query: searchText)
        service?.fetchData(endPoint: .search, with: parameters, completion: { (response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let movies):
                self.remoteRequestHandler?.moviesFound(found: movies)
            }
            
        })
    }
}

//
//  SearchManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

import Foundation

class SearchManager: SearchingDataProtocol {
    func getMovie(with parameters: APIParameters) -> [Movie] {
        let semaphore = DispatchSemaphore(value: 0)
        var movies: [Movie] = []
        MovieAPI.shared.fetchData(endPoint: .search, with: parameters, completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                movies = res.movies
            }
            semaphore.signal()
        })
        semaphore.wait()
        
        return movies
    }
    
}

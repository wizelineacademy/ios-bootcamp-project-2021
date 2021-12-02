//
//  MovieAPIModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import Foundation
import os

struct MovieAPIModel {
    private static let logger = Logger(subsystem: Constants.subsystemName, category: "MovieAPIModel")
    
    let movieManager: MovieAPIManager
    
    init(movieManager: MovieAPIManager) {
        self.movieManager = movieManager
    }
    
    func getList(movieFeed: MovieFeed, completion: @escaping (([MovieViewModel]) -> Void)) {
        var movies: [MovieViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        movieManager.getFeed(from: MovieFeed(feedType: .configuration)) { (result: Result<ConfigurationWelcome?, APIError>) in
            switch result {
            case .success(let configuration):
                guard let configuration = configuration else {
                    group.leave()
                    return
                }
                movieManager.getFeed(from: movieFeed) { (result: Result<MovieListResult?, APIError>) in
                    switch result {
                    case .success(let movieListResult):
                        guard let movieListResult = movieListResult else {
                            group.leave()
                            return
                        }
                        let mappedValues = movieListResult.results?.map({
                            return MovieViewModel(movie: $0, configuration: configuration.image)
                        }) ?? []
                        movies.append(contentsOf: mappedValues)
                        group.leave()
                    case .failure(let error):
                        Self.logger.error("The error fetchData \(error.localizedDescription)")
                        group.leave()
                    }
                }
            case .failure(let error):
                Self.logger.error("The error fetchConfiguration \(error.localizedDescription)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(movies)
        }
    }
}

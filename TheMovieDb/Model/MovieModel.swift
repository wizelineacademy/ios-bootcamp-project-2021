//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import Foundation

struct MovieModel {
    
    let movieManager: MovieAPIManager
    
    init(movieManager: MovieAPIManager) {
        self.movieManager = movieManager
    }
    
    func getList(movieFeed: MovieFeed, completion: @escaping (([MovieViewModel]) -> Void)) {
        var movies: [MovieViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        movieManager.getFeed(from: MovieFeed.configuration) { (result: Result<ConfigurationWelcome?, APIError>) in
            switch result {
            case .success(let configuration):
                guard let configuration = configuration else {
                    group.leave()
                    return
                }
                movieManager.getFeed(from: movieFeed) { (result: Result<MovieListResults?, APIError>) in
                    switch result {
                    case .success(let movieListResults):
                        guard let movieListResults = movieListResults else {
                            group.leave()
                            return
                        }
                        let mappedValues = movieListResults.results?.map({
                            return MovieViewModel(movie: $0, configuration: configuration.image)
                        }) ?? []
                        movies.append(contentsOf: mappedValues)
                        group.leave()
                    case .failure(let error):
                        print("The error fetchData \(error.localizedDescription)")
                        group.leave()
                    }
                }
            case .failure(let error):
                print("The error fetchConfiguration \(error.localizedDescription)")
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(movies)
        }
    }
}

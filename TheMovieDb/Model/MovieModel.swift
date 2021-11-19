//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 18/11/21.
//

import Foundation

struct MovieModel {
    
    let movieClient: MovieClient
    
    init(movieClient: MovieClient) {
        self.movieClient = movieClient
    }
    
    func getList(movieFeed: MovieFeed, completion: @escaping (([MovieViewModel]) -> Void)) {
        var movies: [MovieViewModel] = []
        let group = DispatchGroup()
        
        group.enter()
        movieClient.getConfiguration { result in
            switch result {
            case .success(let configuration):
                guard let configuration = configuration else {
                    group.leave()
                    return
                }
                movieClient.getFeed(from: movieFeed, searchId: nil, params: [:]) { result in
                    group.enter()
                    switch result {
                    case .success(let movieListResults):
                        guard let movieListResults = movieListResults else {
                            group.leave()
                            return
                        }
                        movies.append(
                            contentsOf: movieListResults.results?.map(
                                { return MovieViewModel(movie: $0, configuration: configuration.image)}) ?? [])
                        group.leave()
                    case .failure(let error):
                        print("The error fetchData \(error.localizedDescription)")
                        group.leave()
                    }
                }
                group.leave()
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

//
//  APIManager.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Foundation

final class APIManager {
    
    private var movies = [String: [Movie]]()
    
    public func fetch(onCompletion: @escaping([String: [Movie]]) -> Void) {
        let group = DispatchGroup()
        group.enter()
        MovieAPI.shared.getPopular(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies["popularMovies"] = res.movies
            }
            group.leave()
        })
        group.enter()
        MovieAPI.shared.getTopRated(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies["topMovies"] = res.movies
            }
            group.leave()
        })
        group.enter()
        MovieAPI.shared.getNowPlaying(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies["playingNowMovies"] = res.movies
            }
            group.leave()
        })
        group.enter()
        MovieAPI.shared.getUpcoming(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies["upComingMovies"] =  res.movies
            }
            group.leave()
        })
        group.enter()
        MovieAPI.shared.getTrending(completion: {(response: Result<Movies, Error>) in
            switch response {
            case .failure(let error):
                debugPrint(error)
            case .success(let res):
                self.movies["trendingMovies"] = res.movies
            }
            group.leave()
        })
        group.notify(queue: .main) {
            onCompletion(self.movies)
        }
    }
}

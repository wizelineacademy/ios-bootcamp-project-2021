//
//  MainViewModel.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 21/11/21.
//

import Foundation

public class MainViewModel {
    private var client = MovieClient()
    private var movies: [Movie] = []
    
    init(client: MovieClient = MovieClient()) {
        self.client = client
    }
    
    func loadMoviesData(with index: Int, page: Int, completion: @escaping () -> Void) {
        
        var endpoint: MovieFeed {
            switch index {
            case 0: return .nowPlaying(page)
            case 1: return .popular(page)
            case 2: return .topRated(page)
            case 3: return .upcoming(page)
            case 4: return .trending(page)
            default: fatalError()
            }
        }
        
        client.getFeed(from: endpoint) { [weak self] (result) in
      
            switch result {
            case .success(let listOf):
                guard let movieResult = listOf?.results else { return }
                self?.movies += movieResult
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
    
    func resetMovies() {
        movies = []
    }
    
    func numberOfRowsInSection() -> Int {
        return movies.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}

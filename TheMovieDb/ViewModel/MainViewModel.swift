//
//  MainViewModel.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 21/11/21.
//

import Foundation

public class MainViewModel {
    private var client = MovieClient()
    private var movies = [Movie]()
    
    
    init(client: MovieClient = MovieClient()) {
        self.client = client
    }
    
   
    func loadMoviesData(from movieType: MovieFeed, completion: @escaping () -> ()) {
        client.getFeed(from: movieType) { [weak self] (result) in
      
            switch result {
            case .success(let listOf):
                guard let movieResult = listOf?.results else { return }
                self?.movies = movieResult
                completion()
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return movies.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}

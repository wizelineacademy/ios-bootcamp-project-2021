//
//  MovieManager.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 01/11/21.
//

import Foundation

class MovieManager{
    let movieBaseURL = "https://api.themoviedb.org/3"
    let apiKey = "?api_key=444cd656b00475d785aa41a9c43b2e44"
    var apiService = APIService()
    var movies = [Movie]()
    
    func fetchMoviesData(type: String, completion: @escaping () -> ()) {
        let urlString: String
        
        if type == "trending" {
            urlString = "\(movieBaseURL)/\(type)/movie/day\(apiKey)&language=en"
        } else {
            urlString = "\(movieBaseURL)/movie/\(type)\(apiKey)&language=en"
        }
        // weak self - prevent retain cycles
        apiService.getMoviesData(url: urlString) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.movies = listOf.results
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing JSON data: \(error)")
            }
        }
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        //if popularMovies.count != 0 {
        //    return popularMovies.count
        //}
        return movies.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
}


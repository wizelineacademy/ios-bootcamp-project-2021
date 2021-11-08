//
//  MovieManager.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 01/11/21.
//

import Foundation

class MovieManager{
    let movieBaseURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "?api_key=444cd656b00475d785aa41a9c43b2e44"
    var apiService = APIService()
    var popularMovies = [Movie]()
    //var delegate: MovieManagerDelegate?
    
    func fetchMoviesData(type: String, completion: @escaping () -> ()) {
    let urlString = "\(movieBaseURL)\(type)\(apiKey)"
        // weak self - prevent retain cycles
        apiService.getMoviesData(url: urlString) { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.popularMovies = listOf.movies
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
            }
        }
        
        //performRequest(with: urlString)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        //if popularMovies.count != 0 {
        //    return popularMovies.count
        //}
        return popularMovies.count
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
    
}


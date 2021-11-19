//
//  MovieManager.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 01/11/21.
//

import Foundation

/*class MovieManager{
    var apiService = APIService()
    var movies = [Movie]()
    
    func fetchMoviesData(type: String, completion: @escaping () -> ()) {
        let urlString: String
        
        if type == Constants.MovieLaunch.trending {
            urlString = "\(Constants.URLS.movieBaseURL)/\(type)/movie/day?api_key=\(Constants.URLS.apiKey)&language=en"
        } else {
            urlString = "\(Constants.URLS.movieBaseURL)/movie/\(type)?api_key=\(Constants.URLS.apiKey)&language=en"
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
    
}*/


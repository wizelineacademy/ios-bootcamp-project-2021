//
//  MovieManager.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 01/11/21.
//

import Foundation



protocol MovieManagerDelegate{
    func didMoviesUpdate(_ movieManager: MovieManager, results: MovieResults)
    func didFailWithError(error: Error)
}


struct MovieManager{
    let movieBaseURL = "https://api.themoviedb.org/3/movie/"
    let apiKey = "api_key=444cd656b00475d785aa41a9c43b2e44"
    var delegate: MovieManagerDelegate?
    
    func fetchMovies(movieType: String){
        let urlString = "\(movieBaseURL)\(movieType)?\(apiKey)"
        performRequest(with: urlString)
    }
    
    // MARK: - Request movie results
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let movie = self.parseJSON(safeData){
                        self.delegate?.didMoviesUpdate(self, results: movie)
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Parse movie Results
    
    func parseJSON(_ movieResultsData: Data) -> MovieResults? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(MovieResults.self, from: movieResultsData)
            let page = decodedData.page
            let numResults = decodedData.numResults
            let numPages = decodedData.numPages
            let movieInfo = decodedData.movies
            let movie = MovieResults(page: page, numResults: numResults, numPages: numPages, movies: movieInfo)
            return movie
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    
    }
    
}


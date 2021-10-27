//
//  Facade.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/10/21.
//

import Foundation

enum ShowMoviesURLs: String {
    case Trending = "trending/movie/week?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    case NowPlaying = "movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38&alanguage=en-US&page=1"
    case Popular = "movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en-US&page=1"
    case TopRated = "movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en-US&page=1"
    case Upcoming = "movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en-US&page=1"
}

class MovieFacade {
    
    static let baseURL = "https://api.themoviedb.org/3/"
    
    static func getMovies(showMoviesURL: ShowMoviesURLs, returnMovies: @escaping (MovieResponse) -> Void) {
        
        let url = URL(string: baseURL + showMoviesURL.rawValue)
        guard let requestUrl = url else { fatalError() }
        
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = "GET"
        
        let taskRequest = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let moviesDecoded = try? jsonDecoder.decode(MovieResponse.self, from: data) else {
                    fatalError()
                }
                print(moviesDecoded.page ?? "Not Found")
                returnMovies(moviesDecoded)
            }
        }
        
        taskRequest.resume()
        
        }
}

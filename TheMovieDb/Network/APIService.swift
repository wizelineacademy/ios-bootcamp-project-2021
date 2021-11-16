//
//  APIService.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation

class APIService {

    private var dataTask: URLSessionDataTask?
    
    func getMoviesData(url: String, completion: @escaping (Result<MoviesData, Error>) -> Void) {
        //let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
        
        guard URL(string: url) != nil else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print ("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response Status code \(response.statusCode)")
            
            guard let data = data else {
                print ("Empty Data")
                return
                
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}

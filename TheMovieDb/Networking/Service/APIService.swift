//
//  APIService.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

class APIService {
    
    func getResponse<T: Decodable>(endPoint: APIEndPoints, with parameters: APIParameters, completion: @escaping(Result<T, Error>) -> Void) {
        let  urlBuild = APIBuild(with: parameters, with: endPoint)
        guard let url = urlBuild.buildURL() else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                 completion(.failure(error))
             }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data!)
                completion(.success(result))
            } catch let error {
                completion(.failure(error))
            }
            
        }.resume()
        
    }
    
}

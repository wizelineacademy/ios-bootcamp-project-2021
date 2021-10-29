//
//  APIService.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

class APIService {
    
    func getResponse<T: Decodable>(typeEndpoint: APIEndPoints, completion: @escaping(T?) -> Void) {
        let  urlBuild = APIBuild()
        
        guard let url = urlBuild.buildURL(api: typeEndpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            do {
                let result: T? = try JSONDecoder().decode(T.self, from: data)
                
                guard let saveResults = result else {return}
                
                completion(saveResults)
                
            } catch let error {
                print("________", error.localizedDescription )
                completion(nil)
            }
            
        }.resume()
        
    }
    
}

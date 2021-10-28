//
//  APIService.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

class APIService {
    
    func getResults(completion: @escaping(Movies?) -> Void) {
        
        guard let url = URL(string: APIConst.BASE_URL+"") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            do {
                let result: Movies? = try JSONDecoder().decode(Movies.self, from: data)
                
                guard let saveResults = result else {return}
                
                completion(saveResults)
                
            } catch let error {
                print("________", error.localizedDescription )
                completion(nil)
            }
            
        }.resume()
        
    }
    
}

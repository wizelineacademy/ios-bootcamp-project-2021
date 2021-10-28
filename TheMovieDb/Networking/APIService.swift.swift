//
//  APIService.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

class APIService {
    
    func getResults(completion: @escaping(Results) -> Void) {
        guard let url = URL(string: APIConst.BASE_URL+"/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data, error == nil else { return }
            
            let result = try? JSONDecoder().decode(Results.self, from: data)
            
            if let result = result {
                completion(result)
            } else {
                print("error al convertir array a simple object")
                let result = Results()
                completion(result)
            }
            
        }.resume()
        
    }
    
}

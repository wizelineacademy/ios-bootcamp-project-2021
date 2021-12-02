//
//  getCast.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 28/11/21.
//

import Foundation

struct GetCast {
    
    func getCredits(option: RequestPaths, completion: @escaping (Credits) -> Void) {
        let service = NetworkManager(urlSession: URLSession.shared)
        service.get(path: option.path, urlQueryitems: nil) { response in
            completion(response)
        }
    }
}

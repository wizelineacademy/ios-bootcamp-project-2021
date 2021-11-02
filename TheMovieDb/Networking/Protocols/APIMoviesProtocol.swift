//
//  APIDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Foundation
typealias movieCompletion = (Result<Movies, Error>) -> Void

protocol APIMoviesProtocol: AnyObject {
    func getTrending(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getNowPlaying(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getPopular(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getTopRated(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getUpcoming(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getBySearching(with parameters: APIParameters, completion: @escaping(movieCompletion))
        
    func getSimilar(with parameters: APIParameters, completion: @escaping(movieCompletion))
    
    func getRecommendations(with parameters: APIParameters, completion: @escaping(movieCompletion))
}

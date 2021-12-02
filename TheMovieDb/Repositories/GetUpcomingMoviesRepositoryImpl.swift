//
//  GetUpcomingMoviesRepositoryImplementation.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

final class GetUpcomingMoviesRepositoryImpl: GetUpcomingMoviesRepository {
    private let basePath: String = URLRequestType.upcoming.basePath
    let service = NetworkManager(urlSession: URLSession.shared)
    
    func getUpcomingMovies(completion: @escaping ([Movie]) -> Void) {
        service.get(path: basePath) { [weak self] response in
            self?.handleResponse(response, completion: completion)
        }
    }
    
    func handleResponse(_ response: MovieList, completion: @escaping ([Movie]) -> Void) {
        completion(response.results)
    }
}

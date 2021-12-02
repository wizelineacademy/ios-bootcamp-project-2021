//
//  GetTopRatedMovies.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

protocol GetListMoviesRepository {
    func getListMovies(completion: @escaping ([Movie]) -> Void)
}

//
//  GetMovies.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//

import Foundation

protocol GetMoviesDelegate: AnyObject {
    func didGetMovies(movies: [Movie])
}

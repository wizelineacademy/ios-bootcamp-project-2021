//
//  GetNowPlayingMovies.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

protocol GetNowPlayingMoviesRepository {
    func getNowPlaying(completion: @escaping ([Movie]) -> Void)
}

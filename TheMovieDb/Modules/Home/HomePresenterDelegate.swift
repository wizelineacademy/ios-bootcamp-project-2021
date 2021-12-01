//
//  HomePresenterDelegate.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 26/11/21.
//

import Foundation

protocol HomePresenterDelegate: AnyObject {
    func didStartLoading()
    func didFinishLoading()
    func didStartSearching()
    func didFinishSearching()
    func didUpdateMovies(_ movies: [Movie])
}

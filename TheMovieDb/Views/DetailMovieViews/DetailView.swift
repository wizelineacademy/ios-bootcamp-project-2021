//
//  DetailView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 22/11/21.
//

import Foundation

protocol DetailView: AnyObject {
    func showLoading()
    func stopLoading()
    func loadSectionMovies(listSection: [SectionMovieDetail: [AnyHashable]])
    func configureMovie(movie: MovieViewModel)
}

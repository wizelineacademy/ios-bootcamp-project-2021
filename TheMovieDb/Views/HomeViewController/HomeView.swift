//
//  HomeCollectionView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 10/11/21.
//

import Foundation

protocol HomeView: AnyObject {
    func showLoading()
    func stopLoading()
    func showMoviesHome(arrMovie: [SectionMovie: [Movie]])
    func showEmptyState()
}

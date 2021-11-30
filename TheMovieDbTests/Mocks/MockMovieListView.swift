//
//  MockMovieListView.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 23/11/21.
//

import Foundation
@testable import TheMovieDb

final class MockMovieListView: MovieListView {
    
    var setTitleCalled = false
    var showErrorCalled =  false
    var updateMoviesCalled = false
    var didSelectMovieCalled = false
    var title = ""
    
    func didSetTitle(title: String) {
        setTitleCalled = true
        self.title = title
    }
    
    func showError(_ error: MovieError) {
        showErrorCalled = true
    }
    
    func onUpdateMovies() {
        updateMoviesCalled = true
    }
    
    func didSelectMovie(with id: Int) {
        didSelectMovieCalled = true
    }
}


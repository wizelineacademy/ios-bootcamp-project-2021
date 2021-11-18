//
//  ViewModelsTest.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 17/11/21.
//

import XCTest
@testable import TheMovieDb
class ViewModelsTest: XCTestCase {

    func testDefaultSectionMovieViewModel() {
        let dummyMovie = MovieDummy().getSingleMovie()
        let viewModel = MovieViewModel(movie: dummyMovie)
        XCTAssertEqual(viewModel.isHighSection, false, "No hight section")
        XCTAssertEqual(viewModel.topNumber, "1", "Error in top number")
        XCTAssertNil(viewModel.numerTop, "Is not hight section and not nil")
        let url = URL(string: MovieConst.imageCDN + (viewModel.movie.posterPath ?? ""))
        XCTAssertEqual(viewModel.imageUrl, url, "Movie url is not the same in random")
        
        let dummyMovieSpecific = MovieDummy().getSpecificMovie()
        let viewModelSpecific = MovieViewModel(movie: dummyMovieSpecific)
        XCTAssertEqual(viewModelSpecific.title, "Interstellar", "Error in movie name")
        
        let urlSpecific = URL(string: MovieConst.imageCDN + (viewModelSpecific.movie.posterPath ?? ""))
        XCTAssertEqual(viewModelSpecific.imageUrl, urlSpecific, "Movie url is not the same")
    }

}

//
//  SearchViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import XCTest
@testable import TheMovieDb

class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel?
    
    override func setUp() {
        viewModel = SearchViewModel(facade: MockService())
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testSearchResponse() {
        let expectedSearchResponse = [SearchObject(id: 001,
                                                   name: nil,
                                                   title: "Dune",
                                                   mediaType: "movie"),
                                      SearchObject(id: 005,
                                                   name: "Brad Pit",
                                                   title: nil,
                                                   mediaType: "person")]
        viewModel?.searchObjects(with: "")
        XCTAssertEqual(viewModel?.searchResult.count, expectedSearchResponse.count)
        XCTAssertEqual(viewModel?.searchResult[0].title, expectedSearchResponse[0].title)
        XCTAssertEqual(viewModel?.searchResult[1].name, expectedSearchResponse[1].name)
    }
}

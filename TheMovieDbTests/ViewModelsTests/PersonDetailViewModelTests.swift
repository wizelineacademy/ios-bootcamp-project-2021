//
//  PersonDetailViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import XCTest
@testable import TheMovieDb

class PersonDetailViewModelTests: XCTestCase {
    
    var viewModel: PersonDetailViewModel?
    var facade = MockService()
    
    override func setUp() {
        viewModel = PersonDetailViewModel(facade: facade)
        viewModel?.personID = .zero
    }
    
    override func tearDown() {
        viewModel = nil
    }
    
    func testPersonDetailFailure() {
        facade.failure = true
        viewModel?.detailPersonID()
        XCTAssertNil(viewModel?.person, "Failure failed")
    }
    
    func testPersonDetailSuccess() {
        let expectedPerson = Person(id: 005,
                                    biography: "",
                                    knownForDepartment: "Actor",
                                    name: "Brad Pit",
                                    popularity: 5.1,
                                    profilePath: "",
                                    birthday: "",
                                    deathday: "")
        viewModel?.detailPersonID()
        XCTAssertEqual(viewModel?.person?.name, expectedPerson.name, "Wrong name for person")
    }

}

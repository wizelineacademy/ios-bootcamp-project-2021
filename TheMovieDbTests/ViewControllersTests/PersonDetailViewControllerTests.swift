//
//  PersonDetailViewControllerTest.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import XCTest
@testable import TheMovieDb

class PersonDetailViewControllerTests: XCTestCase {

    var sut: PersonDetailViewController?
    
    override func setUp() {
        sut = PersonDetailViewController(facade: MockService())
        sut?.viewModel?.personID = 0
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testPersonInformation() {
        let expectedPerson = Person(id: 005,
                                    biography: "",
                                    knownForDepartment: "Actor",
                                    name: "Brad Pit",
                                    popularity: 5.1,
                                    profilePath: "",
                                    birthday: "",
                                    deathday: "")
        
        let expectation = XCTestExpectation(description: "Person loaded")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(sut?.personName.text, expectedPerson.name, "Wrong name loaded")
    }

}

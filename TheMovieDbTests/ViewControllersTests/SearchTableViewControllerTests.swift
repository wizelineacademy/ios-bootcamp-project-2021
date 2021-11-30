//
//  SearchTableViewControllerTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import XCTest
@testable import TheMovieDb

class SearchTableViewControllerTests: XCTestCase {

    var sut: SearchTableViewController?
    var navigationMock: MockNavigationController?
    
    override func setUp() {
        sut = SearchTableViewController(facade: MockService())
        
        guard let viewController = sut else {
            return
        }
        
        navigationMock = MockNavigationController(rootViewController: UIViewController())
        navigationMock?.pushViewController(viewController, animated: false)
        navigationMock?.pushViewControllerCalled = false
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testNumberOfRows() {
        sut?.viewDidLoad()
        sut?.viewModel?.searchObjects(with: "")
        let expectation = XCTestExpectation(description: "Search list loaded")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 2, "Wrong quantity of results")
    }
    
    func testZeroNumbersOfRows() {
        let expectation = XCTestExpectation(description: "Search list loaded")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 0, "Wrong quantity of results")
    }
    
    func testDidSelectRow() {
        sut?.viewDidLoad()
        sut?.viewModel?.searchObjects(with: "")
        let expectation = XCTestExpectation(description: "Search list loaded")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        
        guard let tableView = sut?.tableView else {
            XCTFail("There is no tableView present")
            return
        }
        
        sut?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(navigationMock?.pushViewControllerCalled ?? false, "Did not called the did select method")
    }

}

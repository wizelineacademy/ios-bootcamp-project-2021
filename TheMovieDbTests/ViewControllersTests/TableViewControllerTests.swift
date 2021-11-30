//
//  TableViewControllerTests.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import XCTest
@testable import TheMovieDb

class TableViewControllerTests: XCTestCase {
    
    var sut: TableViewController?
    var navigationMock: MockNavigationController?

    override func setUp() {
        sut = TableViewController()
        sut?.loadViewIfNeeded()
        
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
        XCTAssertEqual(sut?.tableView.numberOfRows(inSection: 0), 5, "Wrong quantity of movie options")
    }
    
    func testDidSelectRow() {
        guard let tableView = sut?.tableView else {
            XCTFail("There is no tableView present")
            return
        }
        
        sut?.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(navigationMock?.pushViewControllerCalled ?? false, "Did not called the did select method")
    }
    
    func testDidTapSearchButton() {
        sut?.searchTapped()
        XCTAssertTrue(navigationMock?.pushViewControllerCalled ?? false, "Did not called the search tapped method")
    }
}

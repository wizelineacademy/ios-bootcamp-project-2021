//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import XCTest
import os
@testable import TheMovieDb

class TheMovieDbTests: XCTestCase {
    private static let logger = Logger(subsystem: Constants.subsystemName, category: "TheMovieDbTests")
    
    var mockAPIClient: MockAPIClient!
    var movieModel: MovieAPIModel!
    var originalNetworkData: [MovieViewModel]!

    override func setUp() {
        mockAPIClient = MockAPIClient()
        let movieApiManager = MovieAPIManager(client: mockAPIClient)
        movieModel = MovieAPIModel(movieManager: movieApiManager)
        
        setOriginalData()
    }
    
    func setOriginalData() {
        do {
            var fileName = "Configuration_example"
            let configurationExample: ConfigurationWelcome = try FileParser.createMockResponse(filename: fileName)
            fileName = "Trending_example"
            let trendingExample: MovieListResults = try FileParser.createMockResponse(filename: fileName)
            originalNetworkData = trendingExample.results?.map({
                return MovieViewModel(movie: $0, configuration: configurationExample.image)
            }) ?? []
        } catch {
            Self.logger.error("\(error.localizedDescription)")
        }
    }
    
    func testGetListSuccess() {
        // Create an expectation
        let expectation = self.expectation(description: "MovieList")
        var movieList: [MovieViewModel]?
        
        movieModel.getList(movieFeed: MovieFeed.trending) {
            movieList = $0
            
            // Fullfil the expectation to let the test runner know that it's OK to proceed
            expectation.fulfill()
        }
        // Wait for the expectation to be fullfilled, or time out after 5 seconds.
        // This is where the test runner will pause
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(!(movieList?.isEmpty ?? true), "List shouldn't be empty")
        
        XCTAssertEqual(movieList?.count, originalNetworkData.count, "Data should be the same")
    }
    
    func testGetListError() {
        mockAPIClient.error = .responseUnsuccessful
        
        let expectation = self.expectation(description: "MovieList")
        var movieList: [MovieViewModel]?
        movieModel.getList(movieFeed: MovieFeed.trending) {
            movieList = $0
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(movieList?.isEmpty ?? true, "List should be empty")
    }
}

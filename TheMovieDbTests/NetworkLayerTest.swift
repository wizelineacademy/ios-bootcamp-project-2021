//
//  NetworkLayerTest.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 18/11/21.
//

import XCTest
import Combine
@testable import TheMovieDb

class NetworkLayerTest: XCTestCase {
    
    func testMoviesGet() {
        let fetchMovies = APIService()
        
        let moviesEndpoint: [APIEndPoints] = [.upcoming, .nowPlaying, .trending, .popular, .upcoming]
        moviesEndpoint.forEach {
            moviesCall(fetchMovies: fetchMovies, endPoint: $0)
        }
        
        let relatedMoviesEndpoint: [APIEndPoints] = [.similar, .recommendations]
        relatedMoviesEndpoint.forEach {
            moviesCall(fetchMovies: fetchMovies, endPoint: $0)
        }
        
        let relatedParameters = APIParameters(id: "893")
        relatedMoviesEndpoint.forEach {
            moviesCall(fetchMovies: fetchMovies, endPoint: $0, parameters: relatedParameters)
        }
        
        moviesCall(fetchMovies: fetchMovies, endPoint: .search)
        let searchParameters = APIParameters(query: "Batman")
        moviesCall(fetchMovies: fetchMovies, endPoint: .search, parameters: searchParameters)
    }
    
    private func moviesCall(fetchMovies: APIService, endPoint: APIEndPoints, parameters: APIParameters = APIParameters()) {
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        var cancellables = Set<AnyCancellable>()
        
        fetchMovies.fetchData(endPoint: endPoint, with: parameters)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    XCTAssertTrue(false, "Error in request \(error.localizedDescription)______________")
                    expectation.fulfill()
                }
            }, receiveValue: { (movies: Movies) in
                XCTAssertNotNil(movies, "Movies should not be nil")
                expectation.fulfill()
            }).store(in: &cancellables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
        
    }
    
    func testReviewGet() {
        let fetch = APIService()
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        var cancellables = Set<AnyCancellable>()
        
        fetch.fetchData(endPoint: .review, with: APIParameters())
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    XCTAssertTrue(false, "Error in request \(error.localizedDescription)______________")
                    expectation.fulfill()
                }
            }, receiveValue: { (reviews: Reviews) in
                XCTAssertNotNil(reviews, "Reviews should not be nil")
                expectation.fulfill()
            }).store(in: &cancellables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testCreditCastGet() {
        let fetch = APIService()
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        var cancellables = Set<AnyCancellable>()
        let parameter = APIParameters(id: "20")
        fetch.fetchData(endPoint: .credits, with: parameter)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    XCTAssertTrue(false, "Error in request \(error.localizedDescription)______________")
                    expectation.fulfill()
                }
            }, receiveValue: { (credit: CreditsMovie) in
                XCTAssertNotNil(credit, "CreditMovie should not be nil")
                expectation.fulfill()
            }).store(in: &cancellables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    // test error in decoding data, try to decoding a review with a movie
    func testErrorFetch() {
        let fetch = APIService()
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        var cancellables = Set<AnyCancellable>()
        
        fetch.fetchData(endPoint: .review, with: APIParameters())
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    XCTAssertTrue(true, "There is no error \(error.localizedDescription)______________")
                    expectation.fulfill()
                }
            }, receiveValue: { (movies: Movie) in
                XCTAssertNil(movies, "Movies should be nil")
                expectation.fulfill()
            }).store(in: &cancellables)
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}

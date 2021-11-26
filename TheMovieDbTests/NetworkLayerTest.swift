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
        fetchMovies.fetchData(endPoint: endPoint, with: parameters) { (response: Result<Movies, Error>) in
            switch response {
                
            case .success(let movies):
                XCTAssertNotNil(movies, "Movies should not be nil")
            case .failure(let error):
                XCTAssertTrue(false, "Error in request \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testReviewGet() {
        let fetch = APIService()
        
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        fetch.fetchData(endPoint: .review, with: APIParameters()) { (response: Result<Reviews, Error>) in
            switch response {
                
            case .success(let movies):
                XCTAssertNotNil(movies, "Movies should not be nil")
            case .failure(let error):
                XCTAssertTrue(false, "Error in request \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testMoviesGetCombine() {
        let fetchMovies = APIService()
        var cancellables = Set<AnyCancellable>()
        let expectation = expectation(description: "SomeService does stuff and runs the callback closure")
        fetchMovies.fetchDataCombine(endPoint: .upcoming, with: APIParameters())
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
    
}

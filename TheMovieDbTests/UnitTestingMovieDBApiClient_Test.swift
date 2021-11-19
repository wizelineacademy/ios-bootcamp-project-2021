//
//  UnitTestingMovieDBApiClient_Test.swift
//  TheMovieDbTests
//
//  Created by Michael do Prado on 11/17/21.
//

import XCTest
@testable import TheMovieDb

class UnitTestingMovieDBApiClient_Test: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_FetchMovieResults_returning_URLDataTask() {
    // Given
    let instance = MovieDBClient.shared
    
    let urlString = MovieFeed.nowPlaying
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var movies: [Movie]?
    // When
    instance.fetch(with: request) { json -> MovieFeedResult in
      guard let item = json as? MovieFeedResult else { fatalError("problemms bringing the decodable json") }
      return item
    } completion: { result in
      switch result {
      case .success(let item):
        if item.results != nil {
          movies = item.results
          promise.fulfill()
        }
      case .failure(let error):
        responseError = error
      }
    }
    wait(for: [promise], timeout: 5)
    
    // Then
    XCTAssertEqual(movies?[0].id, 566525)
    XCTAssertEqual(movies?.count, 20)
    XCTAssertNil(responseError)
  }
  
  func test_FetchMovieDetails_returning_URLDataTask() {
    // Given
    let instance = MovieDBClient.shared
    
    let urlString = InfoById.movieDetails(566525)
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var movieDetail: MovieDetails?
    // When
    instance.fetch(with: request) { json -> MovieDetails in
      guard let item = json as? MovieDetails else { fatalError("problemms bringing the decodable json") }
      return item
    } completion: { result in
      switch result {
      case .success(let item):
        movieDetail = item
        promise.fulfill()
      case .failure(let error):
        responseError = error
      }
    }
    wait(for: [promise], timeout: 5)
    
    // Then
    XCTAssertEqual(movieDetail?.id, 566525)
    XCTAssertEqual(movieDetail?.title, "Shang-Chi and the Legend of the Ten Rings")
    XCTAssertNotNil(movieDetail?.backDropPath)
    XCTAssertNil(responseError)
  }
  
  func test_FetchSimilarMovies_returning_URLDataTask() {
    // Given
    let instance = MovieDBClient.shared
    
    let urlString = InfoById.similar(566525)
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var similarMovies: ListSimilarOrRecommendedMovies?
    // When
    instance.fetch(with: request) { json -> ListSimilarOrRecommendedMovies in
      guard let item = json as? ListSimilarOrRecommendedMovies else { fatalError("problemms bringing the decodable json") }
      return item
    } completion: { result in
      switch result {
      case .success(let item):
        if item.results != nil {
          similarMovies = item
          promise.fulfill()
        }
      case .failure(let error):
        responseError = error
      }
    }
    wait(for: [promise], timeout: 5)
    
    // Then
    XCTAssertEqual(similarMovies?.results?.count, 20)
    XCTAssertNil(responseError)
  }
  
  func test_FetchRecommendedMovies_returning_URLDataTask() {
    // Given
    let instance = MovieDBClient.shared
    
    let urlString = InfoById.recommendations(566525)
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var recommendeMovies: ListSimilarOrRecommendedMovies?
    // When
    instance.fetch(with: request) { json -> ListSimilarOrRecommendedMovies in
      guard let item = json as? ListSimilarOrRecommendedMovies else { fatalError("problemms bringing the decodable json") }
      return item
    } completion: { result in
      switch result {
      case .success(let item):
        if item.results != nil {
          recommendeMovies = item
          promise.fulfill()
        }
      case .failure(let error):
        responseError = error
      }
    }
    wait(for: [promise], timeout: 5)
    
    // Then
    XCTAssertFalse((recommendeMovies?.results!.isEmpty)!)
    XCTAssertNil(responseError)
  }
  
  func test_FetchMovieCredits_returning_URLDataTask() {
    // Given
    let instance = MovieDBClient.shared
    
    let urlString = InfoById.credits(370172)
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var credits: Credits?
    // When
    instance.fetch(with: request) { json -> Credits in
      guard let item = json as? Credits else { fatalError("problemms bringing the decodable json") }
      return item
    } completion: { result in
      switch result {
      case .success(let item):
        if item.cast != nil {
          credits = item
          promise.fulfill()
        }
      case .failure(let error):
        responseError = error
      }
    }
    wait(for: [promise], timeout: 5)
    
    // Then
    XCTAssertFalse((credits?.cast!.isEmpty)!)
    XCTAssertEqual(credits?.cast?.count, 55)
    XCTAssertNil(responseError)
  }

}

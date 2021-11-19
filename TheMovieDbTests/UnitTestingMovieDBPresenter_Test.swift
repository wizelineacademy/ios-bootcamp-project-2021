//
//  UnitTestingMovieDBPresenter_Test.swift
//  TheMovieDbTests
//
//  Created by Michael do Prado on 11/19/21.
//

import XCTest
@testable import TheMovieDb

class View: UIViewController, MoviePresenterDelegate {
  var complement: String?
  
  var movies: [Movie] = []
  var moviePresenter: MoviePresenter?
  func showResults<Element>(items: Element) {
    guard let newMovies = items as? MovieFeedResult, let listMovies = newMovies.results else { return }
    print(listMovies.count)
    self.movies = listMovies
  }
}

class UnitTestingMovieDBPresenter_Test: XCTestCase {

  var moviePresenter: MovieViewPresenter?
  var view: View!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    view = View()
    moviePresenter = MoviePresenter(view: view)
    view.moviePresenter = moviePresenter as? MoviePresenter
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    moviePresenter = nil
    view = nil
    try super.tearDownWithError()
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_FetchMovieResults_returning_withPresenter_Result() {
    
    let urlString = MovieFeed.nowPlaying
    let urlComponents = urlString.getUrlComponents(queryItems: nil)
    let request = urlString.request(urlComponents: urlComponents)
    let promise =  expectation(description: "Completion handler invoked")
    var responseError: Error?
    var movies: [Movie]?

    view.moviePresenter?.databaseManager.fetch(with: request) { json -> MovieFeedResult in
      guard let item = json as? MovieFeedResult else { fatalError("problems bringing the decodable json") }
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

}

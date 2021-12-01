//
//  UnitTestMovieDBNetworkLayerCombine_Test.swift
//  TheMovieDbTests
//
//  Created by Michael do Prado on 11/26/21.
//

import XCTest
@testable import TheMovieDb
import Combine

class UnitTestMovieDBNetworkLayerCombine_Test: XCTestCase {
  
  var movieDBClient: MovieClient?
  private var cancellables: Set<AnyCancellable>!
  
  override func setUpWithError() throws {
    self.movieDBClient = MovieClient.shared
    self.cancellables = []
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    self.movieDBClient = nil
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_NetworkDispatcher_GetData_MovieViewModel() {
    // Given
    var allMovies: [MovieViewModel] = []
    let promise = expectation(description: "Get all movies from nowPlaying List")
    // When
    movieDBClient?.fetch(MovieFeed.nowPlaying, kindItem: MovieFeedResult.self)
      .sink(receiveCompletion: { error in
        print(error)
        promise.fulfill()
      },
        receiveValue: { movies in
        guard let listMovies = movies.results else { return }
        allMovies = listMovies.map({ movie in
          MovieViewModel(movie: movie)
        })
      })
      .store(in: &cancellables)
    wait(for: [promise], timeout: 10)
    // Then
    XCTAssertEqual(allMovies.count, 20)
  }
  
  func test_NetworkDispatcher_GetData_MovieDetailViewModel() {
    // Given
    var details: MovieDetailsViewModel?
    let promise = expectation(description: "Get details from a movie with id")
    // When
    movieDBClient?.fetch(InfoById.movieDetails(550), kindItem: MovieDetails.self)
      .sink(receiveCompletion: { error in
        print(error)
        promise.fulfill()
      },
        receiveValue: { moviesDetails in
        details = MovieDetailsViewModel(movieDetails: moviesDetails)
      })
      .store(in: &cancellables)
    
    wait(for: [promise], timeout: 10)
    // Then
    XCTAssertEqual(details?.title, "Fight Club")
    XCTAssertEqual(details?.overview, "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.")
  }
  
  func test_NetworkDispatcher_GetData_PersonViewModel() {
    // Given
    var person: PersonViewModel?
    let promise = expectation(description: "Get the first actor in the credits list")
    // When
    movieDBClient?.fetch(InfoById.credits(550), kindItem: Credits.self)
      .sink(receiveCompletion: { error in
        print(error)
        promise.fulfill()
      },
        receiveValue: { credits in
        guard let cast = credits.cast else { return }
        person = PersonViewModel(person: cast[0])
      })
      .store(in: &cancellables)
    wait(for: [promise], timeout: 10)
    // Then
    XCTAssertEqual(person?.name, "Edward Norton")
    XCTAssertEqual(person?.character, "The Narrator")
  }
  
  func test_NetworkDispatcher_GetData_ReviewViewModel() {
    // Given
    var review: ReviewViewModel?
    let promise = expectation(description: "Get 1 review from a reviews list")
    // When
    movieDBClient?.fetch(InfoById.reviews(550), kindItem: ListReviews.self)
      .sink(receiveCompletion: { error in
        print(error)
        promise.fulfill()
      },
        receiveValue: { reviews in
        guard let listReviews = reviews.results else { return }
        review = ReviewViewModel(review: listReviews[0])
      })
      .store(in: &cancellables)
    wait(for: [promise], timeout: 10)
    // Then
    XCTAssertEqual(review?.author, "Goddard")
    XCTAssertEqual(review?.content, "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.")
  }

}

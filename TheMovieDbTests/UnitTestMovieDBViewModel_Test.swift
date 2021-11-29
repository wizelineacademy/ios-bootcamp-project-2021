//
//  UnitTestMovieDBViewModel_Test.swift
//  TheMovieDbTests
//
//  Created by Michael do Prado on 11/26/21.
//

import XCTest
@testable import TheMovieDb

class UnitTestMovieDBViewModel_Test: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_MovieViewModel_inicialization_withDummyData() {
    let movie = Movie(id: 12345, title: "Home alone 2", poster: nil)
    
    let movieViewModel = MovieViewModel(movie: movie)
    
    XCTAssertEqual(movieViewModel.title, "Home alone 2")
    XCTAssertNil(movieViewModel.poster)
  }
  
  func test_MovieDetailsViewModel_inicialization_withDummyData() {
    let movieDetails = MovieDetails(
      id: 1425167,
      title: "Home alone 3",
      overview: "9-year-old Alex Pruitt is home alone with the chicken pox. Turns out, due to a mix-up among nefarious spies, Alex was given a toy car concealing a top-secret microchip. Now Alex must fend off the spies as they try break into his house to get it back.",
      releaseDate: "12/12/1997",
      voteAverage: 5.7,
      budget: 32000000,
      backDropPath: nil,
      revenue: 79082515,
      originalLanguage: "English",
      status: "Released"
    )
    
    let movieDetailsViewModel = MovieDetailsViewModel(movieDetails: movieDetails)
    
    XCTAssertEqual(movieDetailsViewModel.title, movieDetails.title)
    XCTAssertEqual(movieDetailsViewModel.budget, "$32,000,000")
    XCTAssertEqual(movieDetailsViewModel.revenue, "$79,082,515")
    XCTAssertNil(movieDetailsViewModel.backDropPath)
  }
  
  func test_PersonViewModel_inicialization_withDummyData() {
    let person = Person(id: 982030, name: "Zendaya", profilePath: nil, character: "Mary Jane")
    
    let personViewModel = PersonViewModel(person: person)
    
    XCTAssertEqual(personViewModel.name, person.name)
    XCTAssertEqual(personViewModel.character, person.character)
    XCTAssertNil(personViewModel.profilePath)
  }
  
  func test_ReviewViewModel_inicialization_withDummyData() {
    let review = MovieReview(id: "9278004", author: "Memrise", content: "some kind of critic", authorDetails: AuthorDetails(avatarPath: nil, rating: 8.0))
    
    let reviewViewModel = ReviewViewModel(review: review)
    
    XCTAssertEqual(reviewViewModel.author, review.author)
    XCTAssertEqual(reviewViewModel.content, review.content)
    XCTAssertNil(reviewViewModel.profileImageAuthor)
    XCTAssertEqual(reviewViewModel.score, review.authorDetails.rating)
  }
  
}

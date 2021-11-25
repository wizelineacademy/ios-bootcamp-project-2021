//
//  UnitTestingMovieDBModels_Test.swift
//  TheMovieDbTests
//
//  Created by Michael do Prado on 11/17/21.
//

import XCTest
@testable import TheMovieDb

class UnitTestingMovieDBModels_Test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
// Movie model testing
  func test_MovieModel_inicialization_withDummyData() {
    // Given
    let json = """
    {
      "id": 12345,
      "title": "Home alone 1",
      "poster_path": "719823937.jpg",
      "release_date": "2002/12/24"
    }
    """.data(using: .utf8)!
    // When
    do {
      let item = try JSONDecoder().decode(Movie.self, from: json)
      // Then
      XCTAssertEqual(item.title, "Home alone 1")
      XCTAssertNotNil(item.poster)
    } catch let error {
      print(error.localizedDescription)
    }

  }
  // MovieDetail model testing
  func test_MovieDetailsModel_inicialization_withDummyData() {
    // Given
    let json = """
    {
      "id": 12345,
      "title": "Home alone 2",
      "backdrop_path": "719823937.jpg",
      "release_date": "2002/12/24",
      "revenue": 1000000,
      "status": "released",
      "original_language": "en",
      "budget": 10000,
      "overview": "party for christmas",
      "vote_average": 7.8
    }
    """.data(using: .utf8)!
    // When
    do {
      let item = try JSONDecoder().decode(MovieDetails.self, from: json)
      // Then
      XCTAssertEqual(item.voteAverage, 7.8)
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func test_PersonModel_inicialization_withDummyData() {
    // Given
    let json = """
    {
      "id": 192930,
      "name": "Makaula Culkin",
      "profile_path": "some picture",
      "character": "Kevin McCallister",
      "popularity": 9.0,
      "known_for_department": "acting",
      "place_of_birth": "Alabama, EEUU",
    }
    """.data(using: .utf8)!
    // When
    do {
      let item = try JSONDecoder().decode(Person.self, from: json)
      // Then
      XCTAssertEqual(item.popularity, 9)
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func test_ReviewModel_inicialization_withDummyData() {
    // Given
    let json = """
    {
       "id": "1892738",
       "author": "some random critic",
       "content": "the critic about the movie",
       "created_at": "2002/12/27",
       "author_details": {
                           "name": "daniel",
                           "username": "daniel123",
                           "avatar_path": "nil",
                           "rating": 9
                          }
    }
    """.data(using: .utf8)!
    // When
    do {
      let item = try JSONDecoder().decode(MovieReview.self, from: json)
      // Then
      XCTAssertEqual(item.author, "some random critic")
    } catch let error {
      print(error.localizedDescription)
    }
  }
  
  func test_SimilarOrRecommendedMovieModel_inicialization_withDummyData() {
    // Given
    let json = """
    {
       "id": 1234561,
       "title": "Home alone 3",
       "poster_path": "some picture about the movie"
    }
    """.data(using: .utf8)!
    // When
    do {
      let item = try JSONDecoder().decode(Movie.self, from: json)
      // Then
      XCTAssertEqual(item.title, "Home alone 3")
    } catch let error {
      print(error.localizedDescription)
    }
  }

}

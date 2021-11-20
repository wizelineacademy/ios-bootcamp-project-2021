//
//  DetailViewModelTests.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 18/11/21.
//

import XCTest
@testable import TheMovieDb

class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    
    var service: MockDetailMovieRepository!
    
    var movie: Movie!
    
    var delegate: MockDetailViewModelDelegate!
    
    override func setUp() {
        super.setUp()
        self.service = MockDetailMovieRepository()
        self.movie = MovieStubGenerator.generateMovie()
        self.delegate = MockDetailViewModelDelegate()
        let dependencies = DetailViewModel.Dependencies(
            movie: movie,
            service: service
        )
        self.sut = DetailViewModel(dependencies: dependencies)
        self.sut.delegate = delegate
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        self.movie = nil
        self.delegate = nil
        super.tearDown()
    }
    
    func testMovieTitle() {
        XCTAssertEqual(sut.getMovieTitle(), movie.title)
    }
    
    func testMovieOverview() {
        XCTAssertEqual(sut.getMovieOverview(), movie.overview)
    }
    
    func testMovieReleaseDate() {
        XCTAssertEqual(sut.getMovieReleaseDate(), movie.releaseDate)
    }
    
    func testMoviePosterPath() {
        XCTAssertEqual(sut.getMoviePosterPath(), movie.posterPath)
    }
    
    func testEmptySimilarMovies() {
        XCTAssertNil(sut.getSimilarMovies())
    }
    
    func testEmptyRecommendations() {
        XCTAssertNil(sut.getRecommendationMovies())
    }
    
    func testEmptyCast() {
        XCTAssertNil(sut.getCast())
    }
    
    func testStartLoadingWhenFetchingRelatedData() {
        sut.requestRelatedMovieData()
        XCTAssertNotNil(delegate.isLoading)
        XCTAssertTrue(delegate.isLoading!)
    }
    
    func testFinishLoadingWhenFetchingRelatedData() {
        sut.requestRelatedMovieData()
        delegate.updateCompletion = {
            XCTAssertNotNil(self.delegate.isLoading)
            XCTAssertFalse(self.delegate.isLoading!)
        }
    }
    
    func testSimilarMoviesAfterSuccessFetching() {
        service.movieList = MovieDBAPIListResponse(
            page: 0,
            results: MovieStubGenerator.generateMovies(5),
            totalPages: 10,
            totalResults: 5
        )
        sut.requestRelatedMovieData()
        delegate.updateCompletion = {
            XCTAssertNotNil(self.sut.getSimilarMovies())
        }
    }
    
    func testRecommendationMoviesAfterSuccessFetching() {
        service.movieList = MovieDBAPIListResponse(
            page: 0,
            results: MovieStubGenerator.generateMovies(5),
            totalPages: 10,
            totalResults: 5
        )
        sut.requestRelatedMovieData()
        delegate.updateCompletion = {
            XCTAssertNotNil(self.sut.getRecommendationMovies())
        }
    }
    
    func testCastAfterSuccessFetching() {
        service.cast = MovieCastResponse(id: 1, cast: CastStrubGenerator.generateCastMembers(10))
        sut.requestRelatedMovieData()
        delegate.updateCompletion = {
            XCTAssertNotNil(self.sut.getCast())
        }
    }

}

class MockDetailViewModelDelegate: DetailViewModelDelegate {
    
    var isLoading: Bool?
    
    var updateCompletion: (() -> Void)?
    
    func didStartLoading() {
        isLoading = true
    }

    func didFinishLoading() {
        isLoading = false
    }

    func didUpdateRelatedMovieData() {
        updateCompletion?()
    }
    
}

class MockDetailMovieRepository: DetailMovieRepository {
    
    var cast: MovieCastResponse?
    
    var movieList: MovieDBAPIListResponse<Movie>?
    
    func getMovieCast(for movie: Movie, completion: @escaping (Result<MovieCastResponse, Error>) -> Void) {
        if let cast = cast {
            completion(.success(cast))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    func getRelatedMovies(for movie: Movie, on related: RelatedMovieTypes, completion: @escaping (Result<MovieDBAPIListResponse<Movie>, Error>) -> Void) {
        if let movieList = movieList {
            completion(.success(movieList))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}

class MovieStubGenerator {
    
    class func generateMovie() -> Movie {
        Movie(
            posterPath: UUID().uuidString,
            overview: UUID().uuidString,
            releaseDate: String(Int.random(in: 1888..<2021)),
            id: Int.random(in: 1..<1000000),
            title: UUID().uuidString
        )
    }
    
    class func generateMovies(_ count: Int) -> [Movie] {
        (0..<count).map { _ in generateMovie() }
    }
    
}

class CastStrubGenerator {
    class func generateCastMember() -> CastMember {
        CastMember(name: UUID().uuidString, character: UUID().uuidString)
    }
    
    class func generateCastMembers(_ count: Int) -> [CastMember] {
        (0..<count).map { _ in generateCastMember() }
    }
}

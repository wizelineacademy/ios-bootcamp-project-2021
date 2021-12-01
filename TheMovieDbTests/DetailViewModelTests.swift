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
    
    var dependencies: DetailViewModel.Dependencies!
    
    var imageLoader: MockImageLoader!
    
    override func setUp() {
        super.setUp()
        self.service = MockDetailMovieRepository()
        self.movie = MovieStubGenerator.generateMovie()
        self.delegate = MockDetailViewModelDelegate()
        self.imageLoader = MockImageLoader()
        self.dependencies = DetailViewModel.Dependencies(
            movie: movie,
            service: service,
            imageLoader: imageLoader
        )
        self.sut = DetailViewModel(dependencies: dependencies)
        self.sut.delegate = delegate
    }
    
    override func tearDown() {
        self.sut = nil
        self.service = nil
        self.movie = nil
        self.delegate = nil
        self.imageLoader = nil
        self.dependencies = nil
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
        let expectation = self.expectation(description: "finishLoadingWhenFetchingRelatedData")
        delegate.updateCompletion = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(self.delegate.isLoading)
        XCTAssertFalse(self.delegate.isLoading!)
    }
    
    func testSimilarMoviesAfterSuccessFetching() {
        service.movieList = MovieDBAPIListResponse(
            page: 0,
            results: MovieStubGenerator.generateMovies(5),
            totalPages: 10,
            totalResults: 5
        )
        sut.requestRelatedMovieData()
        let expectation = self.expectation(description: "similarMoviesAfterSuccessFetching")
        delegate.updateCompletion = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(self.sut.getSimilarMovies())
    }
    
    func testRecommendationMoviesAfterSuccessFetching() {
        service.movieList = MovieDBAPIListResponse(
            page: 0,
            results: MovieStubGenerator.generateMovies(5),
            totalPages: 10,
            totalResults: 5
        )
        sut.requestRelatedMovieData()
        let expectation = self.expectation(description: "recommendationMoviesAfterSuccessFetching")
        delegate.updateCompletion = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(self.sut.getRecommendationMovies())
    }
    
    func testCastAfterSuccessFetching() {
        service.cast = MovieCastResponse(id: 1, cast: CastStrubGenerator.generateCastMembers(10))
        sut.requestRelatedMovieData()
        let expectation = self.expectation(description: "similarMoviesAfterSuccessFetching")
        delegate.updateCompletion = {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(self.sut.getCast())
    }
    
    func testNilImageAfterImageLoadWithInvalidURL() {
        dependencies = DetailViewModel.Dependencies(
            movie: MovieStubGenerator.generateMovie(withPosterPath: false),
            service: service,
            imageLoader: imageLoader
        )
        self.sut = DetailViewModel(dependencies: dependencies)
        let expectation = self.expectation(description: "nilImageAfterImageLoadWithInvalidURL")
        var result: UIImage?
        sut.getMoviePoster { image in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNil(result)
    }
    
    func testImageAfterImageLoad() {
        imageLoader.image = UIImage()
        let expectation = self.expectation(description: "imageAfterImageLoad")
        var result: UIImage?
        sut.getMoviePoster { image in
            result = image
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertNotNil(result)
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
    
    class func generateMovie(withPosterPath: Bool = true) -> Movie {
        Movie(
            posterPath: withPosterPath ? UUID().uuidString : nil,
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

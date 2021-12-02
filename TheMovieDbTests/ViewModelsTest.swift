//
//  ViewModelsTest.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 17/11/21.
//

import XCTest
@testable import TheMovieDb
class ViewModelsTest: XCTestCase {

    // MovieViewModel
    func testDefaultSectionMovieViewModel() {
        let dummyMovie = MovieDummy().getSingleMovie()
        let viewModel = MovieViewModel(movie: dummyMovie)
        XCTAssertEqual(viewModel.isHighSection, false, "No hight section")
        XCTAssertEqual(viewModel.topNumber, "1", "Error in top number")
        XCTAssertNil(viewModel.numerTop, "Is not hight section and not nil")
        let url = URL(string: MovieConst.imageCDN + (viewModel.movie.posterPath ?? (viewModel.movie.backdropPath ?? "")))
        XCTAssertEqual(viewModel.imageUrl, url, "Movie url is not the same in random")
        
        let dummyMovieSpecific = MovieDummy().getSpecificMovie()
        let viewModelSpecific = MovieViewModel(movie: dummyMovieSpecific)
        XCTAssertEqual(viewModelSpecific.title, "Interstellar", "Error in movie name")
        
        let urlSpecific = URL(string: MovieConst.imageCDN + (viewModelSpecific.movie.posterPath ?? ""))
        XCTAssertEqual(viewModelSpecific.imageUrl, urlSpecific, "Movie url is not the same")
    }
    
    func testHightSectionMovieViewModel() {
        let dummyMovie = MovieDummy().getSingleMovie()
        var viewModel = MovieViewModel(movie: dummyMovie)
        viewModel.isHighSection = true
        XCTAssertEqual(viewModel.isHighSection, true, "Should be hight section")
    }
    
    func testNumberTopSectionMovieViewModel() {
        let dummyMovie = MovieDummy().getSingleMovie()
        var viewModel = MovieViewModel(movie: dummyMovie)
        viewModel.isHighSection = true
        viewModel.numerTop = 1
        XCTAssertEqual(viewModel.topNumber, "2", "Error in top number")
    }
    
    // MovieDetailViewModel
    func testMovieDetailViewModel() {
        let dummyMovie = MovieDummy().getSingleMovie()
        let viewModel = MovieDetailViewModel(movie: dummyMovie)
        let url = URL(string: MovieConst.imageCDN + (viewModel.movie.posterPath ?? (viewModel.movie.backdropPath ?? "")))
        XCTAssertEqual(viewModel.imageUrl, url, "Movie url is not the same in random")
        XCTAssertEqual(viewModel.overview, viewModel.movie.overview, "Overview is not the same")
        XCTAssertEqual(viewModel.date, "   🗓 \(viewModel.movie.releaseDate ?? "")   ", "Date is not the same")
        XCTAssertEqual(viewModel.popularity, "   🌟 \(Int(viewModel.movie.popularity))%   ", "Erro in popularity")
        XCTAssertEqual(viewModel.votes, "   👍 \(viewModel.movie.voteCount)   ", "Votes is not equal")

        let dummyMovieSpecific = MovieDummy().getSpecificMovie()
        let viewModelSpecific = MovieDetailViewModel(movie: dummyMovieSpecific)
        XCTAssertEqual(viewModelSpecific.title, "Interstellar", "Error in movie name")
        
        let urlSpecific = URL(string: MovieConst.imageCDN + (viewModelSpecific.movie.backdropPath ?? (viewModelSpecific.movie.posterPath ?? "")))
        XCTAssertEqual(viewModelSpecific.imageUrl, urlSpecific, "Movie url is not the same")
    }
    
    // ReviewViewModel
    func testReviewViewModel() {
        
        let dummyReview = ReviewDummy().getSingleReview()
        let viewModel = ReviewViewModel(review: dummyReview)
        XCTAssertEqual(viewModel.content, viewModel.review.content, "Content is not the same")
        XCTAssertEqual(viewModel.author, viewModel.review.author, "Author name is no correct")
        
        var safeUrl = viewModel.review.authorDetails.avatarPath ?? MovieConst.defaultImage
        
        if safeUrl.prefix(1) == "/" {
            safeUrl.removeFirst()
        }
        if !safeUrl.contains("http") {
            safeUrl = MovieConst.defaultImage
        }
        
        let url = URL(string: safeUrl)
        XCTAssertEqual(viewModel.imageUrl, url, "url is not the same in random")
        
        let dummyReviewSpecific = ReviewDummy().getSpecificReview(index: 1)
        let viewModelSpecific = ReviewViewModel(review: dummyReviewSpecific)
        XCTAssertEqual(viewModelSpecific.content, "lorem ipsum", "Error in review content")
        
        let urlSpecific = URL(string: "https://secure.gravatar.com/avatar/46a1a92c7411a32e58148c83a9f596d7.jpg")
        XCTAssertEqual(viewModelSpecific.imageUrl, urlSpecific, "Review url is not the same")
        
        let dummyReviewSpecific2 = ReviewDummy().getSpecificReview(index: 2)
        let viewModelSpecific2 = ReviewViewModel(review: dummyReviewSpecific2)
        XCTAssertEqual(viewModelSpecific2.author, "Wuchak", "Error in review name")
        
        let urlSpecific2 = URL(string: MovieConst.defaultImage)
        XCTAssertEqual(viewModelSpecific2.imageUrl, urlSpecific2, "Review url is not the same")
        
    }
    
    // CatViewModel
    func testCastViewModel() {
        
        let dummyCast = CastDummy().getSingleCast()
        let viewModel = CastViewModel(cast: dummyCast)
        XCTAssertEqual(viewModel.character, viewModel.cast.character ?? "", "Name is not the same")
        XCTAssertEqual(viewModel.name, viewModel.cast.name ?? "", "Actor name is no correct")
        
        let safeUrl = (MovieConst.imageCDN + (viewModel.cast.profilePath ?? ""))
        
        let url = URL(string: safeUrl)
        XCTAssertEqual(viewModel.imageUrl, url, "url is not the same in random")
        
        let dummyCastSpecific = CastDummy().getSpecificCast(index: 1)
        let viewModelSpecific = CastViewModel(cast: dummyCastSpecific)
        
        let urlSpecific = URL(string: MovieConst.imageCDN + "Ben_Affleck_by_Gage_Skidmore_3.jpg")
        XCTAssertEqual(viewModelSpecific.imageUrl, urlSpecific, "Actor url is not the same")
        XCTAssertEqual(viewModelSpecific.name, "Ben Affleck", "Error in actor name")
        XCTAssertEqual(viewModelSpecific.character, "Batman", "Error in character")
    
    }
    
}

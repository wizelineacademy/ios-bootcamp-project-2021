//
//  MoviesHomeDelegateTest.swift
//  TheMovieDbTests
//
//  Created by developer on 29/11/21.
//

import XCTest
@testable import TheMovieDb

class MoviesHomeDataSourceTest: XCTestCase {

    var feed = MoviesFeed(listsOfElements: [Topic.popular: MovieList(results: [Movie(title: "1", id: 1, posterPath: "path1", overview: "1")])])
    var delegate = MoviesDataSource()
    var collectionView: UICollectionView!
    
    override func setUp() {
        collectionView = UICollectionView(frame: CGRect(x: 1, y: 1, width: 1, height: 1), collectionViewLayout: CompotitionalLayoutCreator.createLayoutForMovies())
        delegate.feed = feed
        super.setUp()
    }
    
    func testNumberOfSectionInCollection() {
       XCTAssertTrue(delegate.numberOfSections(in: collectionView) == 1)
    }
    
    func testMumberOfRows() {
        let count = feed.listsOfElements[.popular]?.results.count ?? 0
        XCTAssertTrue(delegate.collectionView(collectionView, numberOfItemsInSection: count) ==  1)
    }
}

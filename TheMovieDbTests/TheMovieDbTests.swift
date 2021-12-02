//
//  TheMovieDbTests.swift
//  TheMovieDbTests
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import XCTest
@testable import TheMovieDb

final class TheMovieDbTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func test_workerTesting() {
        var trendingRequest = TrendingRequest()
        let worker = ListSectionSceneWorker(service: MockNetworkAPI(),
                                            request: trendingRequest)
        worker.callToMoviesRequest(completion: { response in
            XCTAssertNotNil(response, "the response is nil")
            trendingRequest.nextPage()
            XCTAssertEqual(trendingRequest.page, 2)
        }, onError: { error in
            XCTAssertNil("Not executing")
        })
        worker.resetCounter()
        XCTAssertEqual(trendingRequest.page, 1)
    }
    
    func test_workerTestingError() {
        let trendingRequest = TrendingRequest()
        let worker = ListSectionSceneWorker(service: MockNetworkAPI(isErrorTesting: true),
                                            request: trendingRequest)
        worker.callToMoviesRequest(completion: { response in
            XCTAssertNil("Not executing")
        }, onError: { error in
            XCTAssertNotNil(error, "Error is nil")
        })
        worker.resetCounter()
        XCTAssertEqual(trendingRequest.page, 1)
    }
    
    func test_interactor() {
        let trendingRequest = TrendingRequest()
        let interactor = ListSectionSceneInteractor()
        let presenter = ListSectionScenePresenter()
        let router = ListSectionSceneRouter()
        let viewController = ListSectionSceneViewController(section: .trending)
        viewController.interactor = interactor
        router.source = viewController
        viewController.router = router
        presenter.viewController = viewController
        interactor.worker = ListSectionSceneWorker(service: MockNetworkAPI(),
                                                   request: trendingRequest)
        interactor.presenter = presenter
        
        viewController.router = router
        viewController.viewDidLoad()
        viewController.interactor?.callSectionQuery()
        viewController.interactor?.resetCounter()
        interactor.worker = ListSectionSceneWorker(service: MockNetworkAPI(isErrorTesting: true),
                                                   request: trendingRequest)
        viewController.interactor?.callSectionQuery()
    }
}

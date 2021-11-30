//
//  SearchViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log
import Combine

final class SearchViewModel {
    
    var loadSearch: (() -> Void)?
    var searchResult: [SearchObject] = [] {
        didSet {
            DispatchQueue.main.async {
                self.loadSearch?()
            }
        }
    }
    
    var facade: MovieService
    init(facade: MovieService) {
        self.facade = facade
        os_log("SearchViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    var showError: ((MovieError) -> Void)?
    var subscriptions = Set<AnyCancellable>()
    
    func searchObjects(with text: String) {
        facade.get(type: MovieResponse<SearchObject>.self, search: text, endpoint: .search)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("SearchViewModel failure", log: OSLog.viewModel, type: .error)

                case .finished: break
                }
            }, receiveValue: { movieResponse in
                guard let resultObject = movieResponse.results else {
                    self.showError?(.invalidResponse)
                    os_log("SearchViewModel failure", log: OSLog.viewModel, type: .error)
                    return
                }
                var searchArray: [SearchObject] = []
                for object in resultObject {
                    if object.mediaType != "tv" {
                        searchArray.append(object)
                    }
                }
                self.searchResult = searchArray
            })
            .store(in: &subscriptions)
    }
}

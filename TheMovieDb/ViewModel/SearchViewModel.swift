//
//  SearchViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log

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
    
    func searchObjects(with text: String) {
        facade.get(search: text, endpoint: .search) { [weak self] (response: Result<MovieResponse<SearchObject>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                guard let resultObject = movieResponse.results else {
                    self.showError?(.invalidResponse)
                    os_log("SearchViewModel error", log: OSLog.viewModel, type: .error)
                    return
                }
                var searchArray: [SearchObject] = []
                for object in resultObject {
                    if object.mediaType != "tv" {
                        searchArray.append(object)
                    }
                }
                self.searchResult = searchArray
            case .failure(let failureResult):
                self.showError?(failureResult)
                os_log("SearchViewModel failure", log: OSLog.viewModel, type: .error)
            }
        }
    }
}

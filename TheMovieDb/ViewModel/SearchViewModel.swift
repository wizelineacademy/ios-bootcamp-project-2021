//
//  SearchViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation

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
    }
    
    var showError: ((MovieError) -> Void)?
    
    func searchObjects(with text: String) {
        facade.get(search: text, endpoint: .search) { [weak self] (response: Result<MovieResponse<SearchObject>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                guard let resultObject = movieResponse.results else {
                    self.showError?(.invalidResponse)
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
            }
        }
    }
}

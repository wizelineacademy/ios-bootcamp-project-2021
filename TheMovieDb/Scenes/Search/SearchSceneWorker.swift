//
//  SearchSceneWorker.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import Combine

protocol SearchSceneLogic {
    func resetCounter()
    func callSearchQuery(query: String,
                         completion: @escaping (PageModel<MovieModel>) -> Void,
                         onError: @escaping (NetworkError) -> Void)
}

final class SearchSceneWorker {
    private let service: ExecutorRequest
    private var request: (Request & SearchableModel & PageableModel)?
    private var bag = Set<AnyCancellable>()
    
    init(service: ExecutorRequest = NetworkAPI(),
         request: (Request & SearchableModel & PageableModel)?) {
        self.service = service
        self.request = request
    }
}

extension SearchSceneWorker: SearchSceneLogic {
    
    func resetCounter() {
        request?.clearPages()
    }
    
    func callSearchQuery(query: String,
                         completion: @escaping (PageModel<MovieModel>) -> Void,
                         onError: @escaping (NetworkError) -> Void) {
        request?.searchText(query)
        service.execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    onError(error)
                default:
                    return
                }
            }, receiveValue: { (result: PageModel<MovieModel>?) in
                guard let result = result else {
                    return
                }
                self.request?.nextPage()
                completion(result)
            }).store(in: &bag)
    }
}

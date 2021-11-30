//
//  ListSectionSceneWorker.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import Foundation
import Combine

protocol ListSectionSceneLogic {
    func resetCounter()
    func callToMoviesRequest(completion: @escaping (PageModel<MovieModel>) -> Void)
}

final class ListSectionSceneWorker {
    private let service: ExecutorRequest
    private var request: (Request & PageableModel)?
    private var bag = Set<AnyCancellable>()
    
    init(service: ExecutorRequest = NetworkAPI(),
         request: (Request & PageableModel)?) {
        self.service = service
        self.request = request
    }
}

extension ListSectionSceneWorker: ListSectionSceneLogic {
    
    func resetCounter() {
        request?.clearPages()
    }
    
    func callToMoviesRequest(completion: @escaping (PageModel<MovieModel>) -> Void) {
        service.execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Toast.showToast(title: error.localizedDescription)
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

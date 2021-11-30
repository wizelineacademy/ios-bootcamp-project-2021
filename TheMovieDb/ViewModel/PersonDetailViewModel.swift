//
//  PersonDetailViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation
import os.log
import Combine

final class PersonDetailViewModel {
    var personID: Int?
    var loadPerson: (() -> Void)?
    var person: Person? {
        didSet {
            DispatchQueue.main.async {
                self.loadPerson?()
            }
        }
    }
    var showError: ((MovieError) -> Void)?
    var facade: MovieService
    var subscriptions = Set<AnyCancellable>()
    
    init(facade: MovieService) {
        self.facade = facade
        os_log("PersonDetailViewModel initialized", log: OSLog.viewModel, type: .debug)
    }
    
    func detailPersonID() {
        guard let id = personID else { return }
        facade.get(type: Person.self, search: nil, endpoint: .personDetails(id: id))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case let .failure(error):
                    self.showError?(error)
                    os_log("PersonDetailViewModel failure", log: OSLog.viewModel, type: .error)
                case .finished: break
                }
            }, receiveValue: { person in
                self.person = person
            })
            .store(in: &subscriptions)
    }
}

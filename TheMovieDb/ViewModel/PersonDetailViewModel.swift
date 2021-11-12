//
//  PersonDetailViewModel.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 12/11/21.
//

import Foundation

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
    init(facade: MovieService) {
        self.facade = facade
    }
    
    func detailPersonID() {
        guard let id = personID else { return }
        facade.get(search: nil, endpoint: .personDetails(id: id)) { [weak self] (response: Result<Person, MovieError>) in
            guard let self = self else { return }
            switch response {
            case.success(let person):
                self.person = person
            case .failure(let failureResult):
                self.showError?(failureResult)
            }
        }
    }
}

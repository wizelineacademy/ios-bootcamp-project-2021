//
//  ReviewDetailPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import Foundation
import Combine

final class ReviewDetailPresenter: ObservableObject {
    
    // MARK: Properties
    private let interactor: ReviewDetailInteractor
    private var cancellables = Set<AnyCancellable>()
    @Published var review: Review?
    
    init(interactor: ReviewDetailInteractor) {
        self.interactor = interactor
        self.interactor.$review
                .assign(to: \.review, on: self)
                .store(in: &cancellables)
    }
        
}

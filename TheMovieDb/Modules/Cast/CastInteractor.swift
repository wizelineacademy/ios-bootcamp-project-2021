//
//  CastInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Combine

final class CastInteractor: CastInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: CastInteractorOutputProtocol?
    private var castWorker: CastWorkerProtocol?
    private var cancellable = Set<AnyCancellable>()
    private let movie: Movie
 
    init(movie: Movie, castWorker: CastWorkerProtocol) {
        self.movie = movie
        self.castWorker = castWorker
    }
    
    func getCast() {
        castWorker?.fetchCredits(with: movie)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    self.presenter?.onError(errorMessage: error.localizedDescription)
                }
            }, receiveValue: { [unowned self] (creditsData: CreditsMovie) in
                let cast = creditsData.cast
                let viewModel = cast.map { CastViewModel(cast: $0) }
                if viewModel.count > 0 {
                    self.presenter?.castFromInteractor(castViewModel: viewModel)
                } else {
                    self.presenter?.noCast(with: InterfaceConst.noCast)
                }
               
            }).store(in: &cancellable)

    }
    
}

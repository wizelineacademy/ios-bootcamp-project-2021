//
//  SearchingInteractor.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Combine

final class SearchingInteractor: SearchingInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: SearchingInteractorOutputProtocol?
    private var moviesWorker: MoviesWorkerProtocol!
    private var cancellable = Set<AnyCancellable>()
    init(movieDetailWorker: MoviesWorkerProtocol) {
        self.moviesWorker = movieDetailWorker
    }
    
    func findMovies(_ searchText: String) {
        let parameters = APIParameters(query: searchText)
        moviesWorker.fetchMovies(endPoint: .search, with: parameters)
            .sink( receiveCompletion: { (completion) in
                if case let .failure(error) = completion {
                    self.presenter?.onError(errorMessage: error.localizedDescription)
                }
            }, receiveValue: { [unowned self] (movies: Movies) in
                let movies = movies.movies
                let viewModel = movies.map { MovieViewModel(movie: $0) }
                self.presenter?.moviesFound(moviesFound: viewModel)
                if viewModel.count == InterfaceConst.noResultsValue {
                    self.presenter?.noSearchesFound(with: InterfaceConst.noMovies)
                }
     
            }).store(in: &cancellable)
    
    }
}

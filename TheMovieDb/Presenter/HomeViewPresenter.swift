//
//  PresenterViewTable.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 08/11/21.
//

import Foundation
import OSLog

protocol HomeViewPresenter {
    func fetchAllMovieList()
    func searchMovie(strMovie: String)
    func didSelectMovie(with item: MovieViewModel)
}

final class HomeViewPresenterImp: HomeViewPresenter {
    
    weak var viewHome: HomeView?
    private let clientMovie: MovieDBClient
    private var dctMoviesBySection: [SectionMovie: [MovieViewModel]] = [:]
    private let navigator: DetailNavigator
    
    init(client: MovieDBClient, navigator: DetailNavigator) {
        self.clientMovie = client
        self.navigator = navigator
    }
    
    func fetchAllMovieList() {
            self.viewHome?.showLoading()
            let downloadGroup = DispatchGroup()
            for sectionMovie in SectionMovie.allCases {
                downloadGroup.enter()
                self.clientMovie.getMoviesFrom(type: sectionMovie, page: 1, id: 0, completion: { [weak self] result in
                    
                    switch result {
                    case .success(let respMovie):
                        guard let movieResult = respMovie,
                              let movieList = movieResult.results
                        else {
                            
                            return
                        }
                        let viewModels = movieList.map {
                            MovieViewModel(movie: $0)
                        }
                        self?.dctMoviesBySection.updateValue(viewModels, forKey: sectionMovie)
                        
                    case .failure(let error):
                        os_log("Error: %@", log: .default, type: .error, String(describing: error))
                    }
                    downloadGroup.leave()
                })
                
            }
        
            downloadGroup.notify(queue: DispatchQueue.main) {
                print("Success!!")
                self.viewHome?.showMoviesHome(arrMovie: self.dctMoviesBySection)
                self.viewHome?.stopLoading()
            }
        
    }
    
    func searchMovie(strMovie: String) {
        self.clientMovie.searchMovies(searchText: strMovie, page: 1, completion: {[weak self] result in
            switch result {
            case .success(let respMovie):
                guard let movieResult = respMovie,
                      let movieList = movieResult.results
                else { return }
                let viewModels = movieList.map {
                    MovieViewModel(movie: $0)
                }
                self?.viewHome?.showMoviesList(arrMovie: viewModels)
            case .failure(let error):
                os_log("Error: %@", log: .default, type: .error, String(describing: error))
            }
        })
    }
    
    func didSelectMovie(with item: MovieViewModel) {
        navigator.goToMovieDetail(with: item)
    }
    
}

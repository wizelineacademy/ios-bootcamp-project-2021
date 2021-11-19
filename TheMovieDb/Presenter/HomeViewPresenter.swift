//
//  PresenterViewTable.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 08/11/21.
//

import UIKit

protocol HomeViewPresenter {
    func fetchAllMovieList()
    func searchMovie(strMovie: String)
    func didSelectMovie(with id: Int)
}

struct MovieViewModel: Hashable {
    let title: String
    let image: URL?
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
      return lhs.identifier == rhs.identifier
    }

    private let identifier = UUID()
    
}

extension MovieViewModel {
    init(movie: Movie) {
        
        self.title = movie.title ?? ""
        if let portraitPhotoURL = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(portraitPhotoURL)") {
            self.image = url
        } else {
            self.image = nil
        }
    }
}

final class HomeViewPresenterImp: HomeViewPresenter {
    
    
    weak var viewHome: HomeView?
    private let clientMovie: MovieDBClient
    private var dctMoviesBySection: [SectionMovie: [MovieViewModel]] = [:]
    private let navigator: DetailNavigator
    
    init(client: MovieDBClient, navigator: DetailNavigator){
        self.clientMovie = client
        self.navigator = navigator
    }
    
    func fetchAllMovieList() {
        DispatchQueue.global(qos: .utility).async {
            self.viewHome?.showLoading()
            let downloadGroup = DispatchGroup()
            for sectionMovie in SectionMovie.allCases {
                downloadGroup.enter()
                self.clientMovie.getMoviesFrom(type: sectionMovie, page: 1, completion: { [weak self] result in
                    
                    switch result {
                    case .success(let respMovie):
                        guard let movieResult = respMovie,
                              let movieList = movieResult.results
                        else {
                            
                            return
                        }
                        let viewModels = movieList.map{
                            MovieViewModel(movie: $0)
                        }
                        self?.dctMoviesBySection.updateValue(viewModels, forKey: sectionMovie)
                        
                    case .failure(let error):
                        print(error)
                    }
                    downloadGroup.leave()
                })
                
            }
            
            downloadGroup.wait()
            downloadGroup.notify(queue: DispatchQueue.main) {
                print("Success!!")
                self.viewHome?.showMoviesHome(arrMovie: self.dctMoviesBySection)
                self.viewHome?.stopLoading()
            }
        }
    }
    
    func searchMovie(strMovie: String){
        self.clientMovie.searchMovies(searchText: strMovie, page: 1, completion: {[weak self] result in
            switch result {
            case .success(let respMovie):
                guard let movieResult = respMovie,
                      let movieList = movieResult.results
                else { return }
                
                self?.viewHome?.showMoviesList(arrMovie: movieList)
            case .failure(let error):
                print(error)
            }

        })
    }
    
    func didSelectMovie(with id: Int) {
        navigator.goToMovieDetail(with: id)
    }
    
}

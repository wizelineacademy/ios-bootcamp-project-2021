//
//  PresenterViewTable.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 08/11/21.
//

import UIKit

protocol HomeViewPresenter {
    func fetchAllMovieList()
}

class HomeViewPresenterImp: HomeViewPresenter {
    
    weak var viewHome: HomeView?
    private let clientMoive: MovieDBClient? = MovieDBClient()
    private var dctMoviesBySection: [SectionMovie: [Movie]] = [:]
    func fetchAllMovieList() {
        DispatchQueue.global(qos: .userInitiated).async {
            let downloadGroup = DispatchGroup()
            for sectionMovie in SectionMovie.allCases {
                downloadGroup.enter()
                self.clientMoive?.getMoviesFrom(type: sectionMovie, page: 1, completion: { [weak self] result in
                    
                    switch result {
                    case .success(let respMovie):
                        guard let movieResult = respMovie,
                              let movieList = movieResult.results
                        else {
                            
                            return
                        }
                        self?.dctMoviesBySection.updateValue(movieList, forKey: sectionMovie)
                        
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
            }
        }
    }
}

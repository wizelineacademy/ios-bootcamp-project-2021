//
//  MakeRequest.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 08/11/21.
//

import Foundation

enum Category {
    case popular
    case upcoming
}

struct SectionData {
    let category: Category
    let movies: [Movie]
}

final class MovieFacade {
    weak var delegate: DataLoaded?
    let getPopularMovies = GetPopularMoviesRepositoryImpl() //pasar por init
    let getUpcomingMovies = GetUpcomingMoviesRepositoryImpl()
    let getNowPlayingMovies = GetNowPlayingMoviesRepositoryImpl()
    let group = DispatchGroup()
    var section: [SectionData] = [] {
        didSet {
            delegate?.reloadData()
        }
    }
    let service = NetworkManager(urlSession: URLSession.shared)
    
    func getAllMovies() {
        var movies: [SectionData] = []
        
        group.enter()
        getPopularMovies.getPopularMovies { [weak self] popularMovies in
            let popular = SectionData(category: .popular, movies: popularMovies)
            movies.append(popular)
            self?.group.leave()
        }
        
        group.enter()
        getUpcomingMovies.getUpcomingMovies { [weak self] upcomingMovies in
            let upcoming = SectionData(category: .upcoming, movies: upcomingMovies)
            movies.append(upcoming)
            self?.group.leave()
        }
        
        group.enter()
        getNowPlayingMovies.getNowPlayingMoviesRepository { [weak self] nowPlayingMovies in
            let nowPlaying = SectionData(category: .upcoming, movies: nowPlayingMovies)
            movies.append(nowPlaying)
            self?.group.leave()
        }
        
        group.notify(queue: .main) {
            self.section = movies
        }
    }
}

protocol DataLoaded: AnyObject {
    func reloadData()
}

//
//  moviesFacade.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 23/11/21.
//
/// Facade class to request all movies.

import Foundation

enum Category: String {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
}

struct SectionData {
    let category: Category
    let movies: [Movie]
}

final class MovieFacade {
    let moviesProvider = GetMovieList()
    var sectionData: [SectionData] = []
    var group = DispatchGroup()
    
    func getAllMovies(completion: @escaping () -> Void ) {
        var sectionInfo: [SectionData] = []
        
        group.enter()
        moviesProvider.getMoviesList(option: .trending) { [weak self] movies in
            let sectionData = SectionData(category: .trending, movies: movies.results)
            sectionInfo.append(sectionData)
            self?.group.leave()
        }
        
        group.enter()
        moviesProvider.getMoviesList(option: .nowPlaying) { [weak self] movies in
            let sectionData = SectionData(category: .nowPlaying, movies: movies.results)
            sectionInfo.append(sectionData)
            self?.group.leave()
        }
        
        group.enter()
        moviesProvider.getMoviesList(option: .popular) { [weak self] movies in
            let sectionData = SectionData(category: .popular, movies: movies.results)
            sectionInfo.append(sectionData)
            self?.group.leave()
        }
        
        group.enter()
        moviesProvider.getMoviesList(option: .topRated) { [weak self] movies in
            let sectionData = SectionData(category: .topRated, movies: movies.results)
            sectionInfo.append(sectionData)
            self?.group.leave()
        }
        
        group.enter()
        moviesProvider.getMoviesList(option: .upcoming) { [weak self] movies in
            let sectionData = SectionData(category: .upcoming, movies: movies.results)
            sectionInfo.append(sectionData)
            self?.group.leave()
        }
        
        group.notify(queue: .main) {
            self.sectionData = sectionInfo
            completion()
        }
    }
}

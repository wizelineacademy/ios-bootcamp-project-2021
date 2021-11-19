//
//  MovieDummy.swift.swift
//  TheMovieDbTests
//
//  Created by Javier Cueto on 17/11/21.
//

import Foundation
@testable import TheMovieDb

struct MovieDummy {
    
    var movies: [Movie] = []
    
    init() {
        let movie1 = Movie(id: 1, title: "Harry Potter", video: true, voteAverage: 23, overview: "Is a batman", releaseDate: "2020/12/12", voteCount: 3, adult: false, backdropPath: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", posterPath: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", popularity: 20, mediaType: "movie")
        movies.append(movie1)
        let movie2 = Movie(id: 2, title: "The Batman", video: true, voteAverage: 23, overview: "Is a batman", releaseDate: "2020/12/12", voteCount: 3, adult: false, backdropPath: "tree-736885__480.jpg", posterPath: nil, popularity: 20, mediaType: "movie")
        movies.append(movie2)
        let movie3 = Movie(id: 3, title: "Interstellar", video: true, voteAverage: 23, overview: "Is a batman", releaseDate: "2020/12/12", voteCount: 3, adult: false, backdropPath: nil, posterPath: nil, popularity: 20, mediaType: "movie")
        movies.append(movie3)
        let movie4 = Movie(id: 4, title: "It", video: true, voteAverage: 23, overview: "Is a batman", releaseDate: "2020/12/12", voteCount: 3, adult: false, backdropPath: nil, posterPath: nil, popularity: 20, mediaType: "movie")
        movies.append(movie4)
        let movie5 = Movie(id: 11, title: "El Chapulin colorado", video: true, voteAverage: 23, overview: "Un chapulin", releaseDate: nil, voteCount: 34, adult: false, backdropPath: nil, posterPath: nil, popularity: 34, mediaType: nil)
        movies.append(movie5)
        let movie6 = Movie(id: 12, title: "Harry Potter 2", video: true, voteAverage: 23, overview: "Is a wizard", releaseDate: "2002/12/12", voteCount: 3, adult: false, backdropPath: "/https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", posterPath: "/https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg", popularity: 20, mediaType: "movie")
        movies.append(movie6)
    }
    
    func getSingleMovie() -> Movie {
        let indexRandom = Int.random(in: 0..<movies.count)
        return movies[indexRandom]
    }
    
    func getSpecificMovie() -> Movie {
        return movies[2]
    }
    
}

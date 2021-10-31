//
//  testMovie.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let video: Bool
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let voteCount: Int
    let adult: Bool
    let backdropPath: String?
    let posterPath: String?
    let popularity: Float
    let mediaType: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case video
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
        case adult
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Float.self, forKey: .voteAverage)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.popularity = try container.decode(Float.self, forKey: .popularity)
        self.mediaType = try? container.decode(String.self, forKey: .mediaType)
    }
    
    init(id: Int, title: String, video: Bool, voteAverage: Float, overview: String, releaseDate: String, voteCount: Int, adult: Bool, backdropPath: String?, posterPath: String?, popularity: Float, mediaType: String?
    ) {
        self.id = id
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteCount = voteCount
        self.adult = adult
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.popularity = popularity
        self.mediaType = mediaType
        
    }
}

class DataManager {
    
    public func fetch() -> [Movie] {
        var movies = [Movie]()
        let movie1 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "hoy", voteCount: 345, adult: false, backdropPath: "/9JVTQNCN4zUF0IfShUvsOFsmo1Q.jpg", posterPath: "/pOaKyhMwALpCTg07eQQu0SQCbL9.jpg", popularity: 30, mediaType: "movie")
        
        let movie2 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "hoy", voteCount: 345, adult: false, backdropPath: "/y9AuabF1SXnn3xZ0tAJLLhv33Uj.jpg", posterPath: "/8RW2runSEc34IwKN2D1aPcJd2UL.jpg", popularity: 30, mediaType: "movie")
        
        let movie3 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "hoy", voteCount: 345, adult: false, backdropPath: "/bsg0mrxUKyJoL4oSGP5mlhEsqp.jpg", posterPath: "/rpOqHZMNIaI4qP4r7nw1B7oA0mx.jpg", popularity: 30, mediaType: "movie")
        
        let movie4 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "hoy", voteCount: 345, adult: false, backdropPath: "/pcDc2WJAYGJTTvRSEIpRZwM3Ola.jpg", posterPath: "/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", popularity: 30, mediaType: "movie")
        
        let movie5 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "hoy", voteCount: 345, adult: false, backdropPath: "/pcDc2WJAYGJTTvRSEIpRZwM3Ola.jpg", posterPath: "/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", popularity: 30, mediaType: "movie")
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movies.append(movie4)
        movies.append(movie5)
        return movies
    }
    
}

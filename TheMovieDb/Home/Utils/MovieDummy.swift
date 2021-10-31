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
        let movie1 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "Six months after the events depicted in The Matrix, Neo has proved to be a good omen for the free humans, as more and more humans are being freed from the matrix and brought to Zion, the one and only stronghold of the Resistance.  Neo himself has discovered his superpowers including super speed, ability to see the codes of the things inside the matrix and a certain degree of pre-cognition. But a nasty piece of news hits the human resistance: 250,000 machine sentinels are digging to Zion and would reach them in 72 hours. As Zion prepares for the ultimate war, Neo, Morpheus and Trinity are advised by the Oracle to find the Keymaker who would help them reach the Source.  Meanwhile Neo's recurrent dreams depicting Trinity's death have got him worried and as if it was not enough, Agent Smith has somehow escaped deletion, has become more powerful than before and has fixed Neo as his next target", releaseDate: "2001-12-18", voteCount: 345, adult: false, backdropPath: "/9JVTQNCN4zUF0IfShUvsOFsmo1Q.jpg", posterPath: "/pOaKyhMwALpCTg07eQQu0SQCbL9.jpg", popularity: 51.198, mediaType: "movie")
        
        let movie2 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "The Lord of the Rings: The Fellowship of the Ring. Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.", releaseDate: "2001-12-18", voteCount: 345, adult: false, backdropPath: "/y9AuabF1SXnn3xZ0tAJLLhv33Uj.jpg", posterPath: "/8RW2runSEc34IwKN2D1aPcJd2UL.jpg", popularity: 51.198, mediaType: "movie")
        
        let movie3 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "Following the death of District Attorney Harvey Dent, Batman assumes responsibility for Dent's crimes to protect the late attorney's reputation and is subsequently hunted by the Gotham City Police Department. Eight years later, Batman encounters the mysterious Selina Kyle and the villainous Bane, a new terrorist leader who overwhelms Gotham's finest. The Dark Knight resurfaces to protect a city that has branded him an enemy.", releaseDate: "2001-12-18", voteCount: 345, adult: false, backdropPath: "/bsg0mrxUKyJoL4oSGP5mlhEsqp.jpg", posterPath: "/rpOqHZMNIaI4qP4r7nw1B7oA0mx.jpg", popularity: 51.198, mediaType: "movie")
        
        let movie4 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "Cobb, a skilled thief who commits corporate espionage by infiltrating the subconscious of his targets is offered a chance to regain his old life as payment for a task considered to be impossible: \"inception\", the implantation of another person's idea into a target's subconscious.", releaseDate: "2001-12-18", voteCount: 345, adult: false, backdropPath: "/pcDc2WJAYGJTTvRSEIpRZwM3Ola.jpg", posterPath: "/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", popularity: 30, mediaType: "movie")
        
        let movie5 = Movie(id: 1, title: "The batman", video: false, voteAverage: 20, overview: "hey", releaseDate: "2001-12-18", voteCount: 345, adult: false, backdropPath: "/pcDc2WJAYGJTTvRSEIpRZwM3Ola.jpg", posterPath: "/tnAuB8q5vv7Ax9UAEje5Xi4BXik.jpg", popularity: 51.198, mediaType: "movie")
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
        movies.append(movie4)
        movies.append(movie5)
        return movies
    }
    
}

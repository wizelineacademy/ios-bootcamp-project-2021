//
//  Results.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
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

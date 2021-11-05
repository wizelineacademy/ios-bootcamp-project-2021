//
//  Reviews.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//

struct Reviews: Decodable {
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case reviews = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.reviews = try container.decode([Review].self, forKey: .reviews)
    }
}

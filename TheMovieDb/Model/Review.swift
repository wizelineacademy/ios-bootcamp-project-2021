//
//  Review.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 27/10/21.
//
import Foundation

struct Review: Decodable {
    let id: String
    let author: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let url: String
    let authorDetail: AuthorReview
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
        case authorDetail = "author_details"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.content = try container.decode(String.self, forKey: .content)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.url = try container.decode(String.self, forKey: .url)
        self.authorDetail = try container.decode(AuthorReview.self, forKey: .authorDetail)
    }
}

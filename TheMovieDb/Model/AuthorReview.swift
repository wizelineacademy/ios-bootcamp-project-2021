//
//  AuthorReview.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 01/11/21.
//

import Foundation
import SwiftUI

struct AuthorReview: Decodable {
    let name: String
    let username: String
    var avatarPath: String?
    let rating: Float?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.username = try container.decode(String.self, forKey: .username)
        self.avatarPath = try? container.decode(String.self, forKey: .avatarPath)
        self.rating = try? container.decode(Float.self, forKey: .rating)
    }
}

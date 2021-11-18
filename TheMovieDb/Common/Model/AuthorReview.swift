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
}

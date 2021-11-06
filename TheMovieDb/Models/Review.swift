//
//  Review.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import Foundation

struct Review: Decodable {
  let content: String
  let author: String
  let rating: Float?
   
  enum CodingKeys: CodingKey {
    case content
    case rating
    case author
    case author_details
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.author = try container.decode(String.self, forKey: .author)
    self.content = try container.decode(String.self, forKey: .content)
    let author_details = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .author_details)
    do {
      self.rating = try author_details.decode(Float.self, forKey: .rating)
    } catch {
      self.rating = 0
    }
    
  }
  
}
struct ReviewsList: Decodable {
  let results: [Review]
  
  enum CodingKeys: String, CodingKey {
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.results = try container.decode([Review].self, forKey: .results)
    
  }
}

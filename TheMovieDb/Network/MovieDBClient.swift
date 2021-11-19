//
//  MovieDBClient.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation
import MapKit

class MovieDBClient: ApiClient {
  
  let session: URLSession
  static let shared = MovieDBClient()
  
  private convenience init() {
    self.init(configuration: .default)
  }
  
  private init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }

}

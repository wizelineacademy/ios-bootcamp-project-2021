//
//  Result.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/1/21.
//

import Foundation

enum Result<Element, U> where U: Error {
  case success(Element)
  case failure(U)
}

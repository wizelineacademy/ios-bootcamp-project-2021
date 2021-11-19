//
//  Result.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 18/11/21.
//

import Foundation

enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

//
//  Result.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 31/10/21.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

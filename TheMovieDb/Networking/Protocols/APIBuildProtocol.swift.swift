//
//  APIBuildProtocol.swift.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 29/10/21.
//
import Foundation

protocol APIBuildProtocol: AnyObject {
    var parameters: APIParameters { get }
    var api: APIEndPoints { get }
    func buildURL() -> URL?
}

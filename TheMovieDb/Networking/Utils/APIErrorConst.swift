//
//  APIErrorConst.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 28/11/21.
//

enum APIErrorConst {
    static let invalidRequest = "Invalid Request".localized()
    static let badRequest = "Bad Request".localized()
    static let unauthorized = "Unauthorized".localized()
    static let forbidden = "No Permission".localized()
    static let notFound = "Page not exist".localized()
    static let error4xx = "Error 400".localized()
    static let serverError = "The service is not working".localized()
    static let error5xx = "The service is not available".localized()
    static let decodingError = "Error in decoding data".localized()
    static let urlSessionFailed = "Error on URL".localized()
    static let unknownError = "Unknown Error".localized()
}

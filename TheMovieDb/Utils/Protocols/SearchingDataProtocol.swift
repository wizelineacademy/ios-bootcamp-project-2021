//
//  SearchingDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

protocol SearchingDataProtocol: AnyObject {
    var delegate: GetMoviesDelegate? { get set }
    func getMovie(with parameters: APIParameters)
}

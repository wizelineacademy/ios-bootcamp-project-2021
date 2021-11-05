//
//  SearchingDataProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 04/11/21.
//

protocol SearchingDataProtocol: AnyObject {
    func getMovie(with parameters: APIParameters) -> [Movie] 
}

//
//  MovieCellProtocol.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/10/21.
//

import UIKit

protocol MovieCellProtocol: UICollectionViewCell {
    func withMovie(with movie: Movie)
}

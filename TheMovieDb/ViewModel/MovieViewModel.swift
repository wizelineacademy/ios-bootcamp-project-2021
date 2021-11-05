//
//  MoviesViewModel.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 03/11/21.
//

import UIKit

struct MovieViewModel {
    
    let movie: Movie
    
    var isHighSection = false
    
    var numerTop: Int?
    
    var imageUrl: URL? {
        var urlImage: String
        if isHighSection {
            urlImage  = MovieConst.imageCDN + (movie.backdropPath ?? (movie.posterPath ?? ""))
        } else {
            urlImage  = MovieConst.imageCDN + (movie.posterPath ?? (movie.backdropPath ?? ""))
        }
  
        return URL(string: urlImage)
    }
    
    var title: String {
        return movie.title
    }
    
    var topNumber: String {
        "\((numerTop ?? 0) + 1)"
    }
}

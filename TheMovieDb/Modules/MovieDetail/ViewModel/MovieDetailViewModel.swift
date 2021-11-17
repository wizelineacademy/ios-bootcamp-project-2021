//
//  MovieDetailViewModel.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 16/11/21.
//

import UIKit

struct MovieDetailViewModel {
    
    let movie: Movie
    
    var imageUrl: URL? {
        let urlImage =  MovieConst.imageCDN + (movie.backdropPath ?? (movie.posterPath ?? ""))
        return URL(string: urlImage)
    }
    
    var title: String {
        return movie.title
    }
    
    var overview: String {
        return movie.overview
    }
    
    var date: String {
        return "   \(movie.releaseDate ?? "")   "
    }
    
    var popularity: String {
        return "   \(Int(movie.popularity))%   "
    }
    
    var votes: String {
        return "   Votes: \(movie.voteCount)   "
    }

}

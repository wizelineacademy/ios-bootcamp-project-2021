//
//  CastViewModel.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Foundation

struct CastViewModel {
    
    let cast: Cast
    
    var imageUrl: URL? {
        let urlImage =  MovieConst.imageCDN +  (cast.profilePath ?? "")
        return URL(string: urlImage)
    }
    
    var name: String {
        cast.name ?? ""
    }
    
    var character: String {
        cast.character ?? ""
    }
}

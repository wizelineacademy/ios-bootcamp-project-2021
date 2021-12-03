//
//  TitleOfSection.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 18/11/21.
//

import Foundation

enum TitleOfSection: String {
    case upcoming = "Upcoming"
    case popular = "Popular"
    case nowPlaying = "Now Playing"
    
    
    var value: String {
        self.rawValue
    }
}

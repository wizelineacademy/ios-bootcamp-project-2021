//
//  ScreenTitle.swift
//  TheMovieDb
//
//  Created by Angel Coronado Quintero on 12/01/22.
//

import Foundation

enum ScreenTitle: String {
    case reviews = "Reviews"
    
    func getScreenTitle() -> String {
        return self.rawValue
    }
}

//
//  DetailsViewModel.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 02/12/21.
//

import Foundation
import SwiftUI

final class DetailsViewModel: ObservableObject {
    @Published var movie: Movie?
    @Published var credits: [Cast] = []
    @Published var similarMovies: [Movie] = []
    @Published var collapsed: Bool = true
    let basePosterUrl = "https://image.tmdb.org/t/p/w500"
    
    func getCast(movieId: Int) {
        if collapsed {
            let getCastRepo = GetCast()
            getCastRepo.getCredits(option: .cast(movieId: movieId)) { credits in
                self.credits.append(contentsOf: credits.cast)
            }
        } else {
            self.credits = []
        }
    }
    
    func getSimilarMovies(movieId: Int) {
        if collapsed {
            let getCastRepo = GetMovieList()
            getCastRepo.getMoviesList(option: .similarMovies(movieId: movieId)) { credits in
                self.similarMovies.append(contentsOf: credits.results)
            }
        } else {
            self.credits = []
        }
    }
    
    func toggleCredits(movieId: Int) {
        if credits.isEmpty {
            getCast(movieId: movieId)
        } else {
            credits = []
        }
    }
}

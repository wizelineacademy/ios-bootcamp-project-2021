//
//  ReviewsViewModel.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 10/11/21.
//

import Foundation
import Combine

class ReviewsViewModel: ViewModel, ObservableObject {
    
    struct Dependencies {
        let movie: Movie
        let service: MovieReviewsRepository
        
        init(movie: Movie, service: MovieReviewsRepository = MovieDBAPI()) {
            self.movie = movie
            self.service = service
        }
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    @Published var reviews = [Review]()

    var isLoading = false
    
    var hasReachedEnd: Bool {
        loadedPages != .zero && loadedPages == totalPages
    }
    
    private var loadedPages: Int = .zero
    
    private var totalPages: Int = .zero
    
    func getReviewsIfNeeded() {
        guard !isLoading,
              loadedPages == .zero || loadedPages < totalPages
            else {
            return
        }
        isLoading.toggle()
        dependencies.service.getMoviewReviews(
            for: dependencies.movie,
            page: loadedPages + 1
        ) { result in
            switch result {
            case .success(let data):
                self.reviews.append(contentsOf: data.results)
                self.loadedPages = data.page
                self.totalPages = data.totalPages
            case .failure(let error):
                print(error)
            }
            self.isLoading.toggle()
        }
    }
    
}

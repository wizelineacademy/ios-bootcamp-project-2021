//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 10/11/21.
//

import SwiftUI
import Combine

struct ReviewsView: View {
    
    @ObservedObject var viewModel: ReviewsViewModel
    
    init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.reviews) { review in
                ReviewRow(review: review)
            }
            LoaderView(hasFinishedLoading: viewModel.hasReachedEnd)
                .onAppear(perform: onAppearLoader)
        }
    }
    
    func onAppearLoader() {
        viewModel.getReviewsIfNeeded()
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(viewModel: ReviewsViewModel(movie: Movie(posterPath: "", adult: false, overview: "", releaseDate: "", genreIds: [0], id: 0, originalTitle: "", originalLanguage: "", title: "", backdrop_path: "", popularity: 1, voteCount: 1, video: true, voteAverage: 1), reviews: [Review(author: "Rick", content: "It's great n.n", id: "1")]))
    }
}

private extension ReviewsViewModel {
    convenience init(movie: Movie, reviews: [Review]) {
        self.init(dependencies: Dependencies(movie: movie))
        self.reviews = reviews
    }
}

// MARK: LoaderView
struct LoaderView: View {
    
    var hasFinishedLoading: Bool
    
    var body: some View {
        if !hasFinishedLoading {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
}

// MARK: ReviewRow
struct ReviewRow: View {
    
    let review: Review
    
    init(review: Review) {
        self.review = review
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(review.author)
                .font(.title)
            Text(review.content)
                .font(.body)
        }
    }
    
}

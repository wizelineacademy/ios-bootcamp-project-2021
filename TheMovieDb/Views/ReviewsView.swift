//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import SwiftUI

struct ReviewsView: View {
    let movieId: Int
    let imageBaseURL: String
    
    @State private var reviews: [MovieReviewViewModel] = []
    @State private var isLoading = true
    
    var body: some View {
        VStack(alignment: .leading) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .foregroundColor(.indigoColor)
            } else {
                ReviewsListView(reviews: reviews)
            }
        }
        .accentColor(.indigoColor)
        .onAppear(perform: fetchData)
    }

    func fetchData() {
        let movieApiManager = MovieAPIManager(client: MovieAPIClient.shared)
        let movieReviewAPIModel = MovieReviewAPIModel(movieApiManager: movieApiManager)
        movieReviewAPIModel.getReviews(imageBaseURL: imageBaseURL, movieId: movieId) { results in
            reviews = results
            isLoading = false
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(
            movieId: 568124,
            imageBaseURL: MovieReviewViewModel.preview.avatarBaseURL
        )
    }
}

//
//  ReviewsView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import SwiftUI

struct ReviewsView: View {
    let reviewId: String
    let imageBaseURL: String
    
    @State private var reviews: [MovieReviewViewModel] = []
    
    var body: some View {
        List(reviews, id: \.id) { review in
            ReviewRowView(review: review)
        }
        .onAppear(perform: fetchData)
    }

    func fetchData() {
        let movieApiManager = MovieAPIManager(client: MovieAPIClient.shared)
        let movieReviewAPIModel = MovieReviewAPIModel(movieApiManager: movieApiManager)
        movieReviewAPIModel.getReviews(imageBaseURL: imageBaseURL, searchId: reviewId) { results in
            reviews = results
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(
            reviewId: "568124",
            imageBaseURL: MovieReviewViewModel.preview.avatarBaseURL
        )
    }
}

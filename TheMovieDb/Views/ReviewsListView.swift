//
//  ReviewsListView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 28/11/21.
//

import SwiftUI

struct ReviewsListView: View {
    @Environment(\.presentationMode) var presentationMode
    let reviews: [MovieReviewViewModel]
    
    var body: some View {
        List {
            if reviews.isEmpty {
                Text("No reviews 😥")
            } else {
                Section {
                    ForEach(reviews, id: \.id) { review in
                        ReviewsRowView(review: review)
                    }
                } header: {
                    Text("Reviews")
                }
            }
            Section {
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct ReviewsListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsListView(reviews: [MovieReviewViewModel.preview])
    }
}

//
//  Search.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/11/21.
//

import SwiftUI

struct ReviewsView: View {
    
    @StateObject var reviewsViewModel: ReviewsViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(reviewsViewModel.reviews) { review in
                    NavigationLink(destination: ReviewsDetailView(review: review)) {
                        Text(review.content ?? "unavailable".localized)
                            .lineLimit(1)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $reviewsViewModel.activeError, content: { error in
            Alert(title: Text(error.titleError),
                  message: Text(error.messageError),
                  dismissButton: .cancel())
        })
        .onAppear {
            reviewsViewModel.reviewsMovie()
        }
    }
}

struct Search_Previews: PreviewProvider {
    
    static var previews: some View {
        ReviewsView(reviewsViewModel: ReviewsViewModel(id: 0, facade: MovieFacade()))
    }
}



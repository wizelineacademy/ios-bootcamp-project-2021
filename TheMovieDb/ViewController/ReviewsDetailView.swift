//
//  ReviewsDetailView.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 25/11/21.
//

import SwiftUI

struct ReviewsDetailView: View {
    var review: ReviewsDetails
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ScrollView {
                    Text(review.content ?? "unavailable".localized)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(width: geometry.size.width)
                }
            }
            .padding(.horizontal)
            Spacer()
            Text(String(format: "author".localized, review.author ?? "unavailable".localized))
                .padding()
        }
    }
}

struct ReviewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let review = ReviewsDetails(author: "Karla", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet leo tempor, rhoncus ex sit amet, sagittis ante. Proin semper nibh ut ipsum sollicitudin, vitae condimentum eros efficitur.")
        ReviewsDetailView(review: review)
    }
}

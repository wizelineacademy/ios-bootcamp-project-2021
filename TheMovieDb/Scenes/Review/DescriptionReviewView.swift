//
//  DescriptionReviewView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/11/21.
//

import SwiftUI

struct DescriptionReviewView: View {
    
    var review: ReviewModel?
    
    var body: some View {
        VStack() {
            Text("Review:")
                .font(.headline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            let review = review?.content ?? "No content"
            Text(review)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing, .bottom], 16.0)
        }.frame(maxWidth: .infinity)
    }
}

struct DescriptionReviewView_Previews: PreviewProvider {
    static var previews: some View {
        let url: String = "/qGVhkysX35RprxjUHOI0vnFeeRc.jpg"
        let author = AuthorDetail(name: "Juan Alfredo",
                                  username: "Kayo",
                                  rating: 9.0,
                                  avatarPath: url)
        let review = ReviewModel(author: "Juan Alfredo",
                                 authorDetails: author,
                                 content: "Is baaaaaad movie!!!, if you see it culd be a great mistake")
        DescriptionReviewView(review: review)
    }
}

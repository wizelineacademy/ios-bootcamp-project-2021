//
//  ReviewSceneView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/11/21.
//

import SwiftUI
import Kingfisher

struct ReviewSceneView: View {
    
    var review: ReviewModel
    @State var valueRating: Float
    
    var body: some View {
        ScrollView() {
            VStack() {
                AuthorView(author: review.authorDetails)
                RatedSwiftUIView(valueRating: $valueRating, maxValue: 10.0,
                                 placeholderText: "--",
                                 strokeWidth: 8.0,
                                 strokeColor: UIColor.ratingFilled,
                                 backStrokeColor: UIColor.ratingNotFilled,
                                 fontType: UIFont.boldSystemFont(ofSize: 20))
                    .frame(width: 84, height: 84)
                DescriptionReviewView(review: review)
            }
        }
    }
}

struct ReviewSceneView_Previews: PreviewProvider {
    static var previews: some View {
        let url: String = "/qGVhkysX35RprxjUHOI0vnFeeRc.jpg"
        let author = AuthorDetail(name: "Juan Alfredo",
                                  username: "Kayo",
                                  rating: 9.0,
                                  avatarPath: url)
        let review = ReviewModel(author: "Juan Alfredo",
                                 authorDetails: author,
                                 content: "Is baaaaaad movie!!!, if you see it culd be a great mistake")
        ReviewSceneView(review: review, valueRating: 10.0)
    }
}

//
//  CommentSwiftUIView.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 30/11/21.
//

import SwiftUI

struct CommentSwiftUIView: View {
    
    var review: [ReviewViewModel] = []
    
    var body: some View {
        NavigationView {
            List(review) { review in
            
            VStack(alignment: .leading) {
                Text(review.author)
                Text(review.content)
                    .font(.subheadline)
            }
          }
        }.navigationBarTitle("Review", displayMode: .inline)
    }
    
    init(review: ReviewViewModel) {
        self.review.append(review)
    }
}

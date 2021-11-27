//
//  ReviewRowView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import SwiftUI
import Kingfisher

struct ReviewRowView: View {
    let review: MovieReviewViewModel
    @State private var viewMore = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                KFImage(review.getAvatarURL())
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                    .layoutPriority(3)
                Text(review.userName)
                    .font(Font.system(.title3, design: .rounded))
                    .layoutPriority(2)
                Spacer()
                Text(review.createdAt)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .layoutPriority(1)
            }
            Text(review.content)
                .font(.callout)
                .foregroundColor(.secondary)
                .lineLimit(viewMore ? nil : Constants.reviewNumberOfLines)
            Button(action: toggleViewMore, label: {
                if viewMore {
                    Label("View Less", systemImage: "arrowtriangle.up.square")
                } else {
                    Label("View More", systemImage: "arrowtriangle.down.square")
                }
            })
                .font(.callout)
        }
    }
    
    func toggleViewMore() {
        withAnimation {
            self.viewMore.toggle()
        }
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView(review: MovieReviewViewModel.preview)
    }
}

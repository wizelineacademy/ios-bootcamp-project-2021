//
//  ReviewsRowView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import SwiftUI

struct ReviewsRowView: View {
    let review: MovieReviewViewModel
    @State private var viewMore = false
    @State private var avatarImage: Image = Image(systemName: "person.crop.circle")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                avatarImage
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                Text(review.userName)
                    .font(Font.system(.title3, design: .rounded))
                Spacer()
            }
            Text(review.createdAt)
                .foregroundColor(.secondary)
                .font(.caption)
            Text(review.content)
                .font(.callout)
                .foregroundColor(.secondary)
                .lineLimit(viewMore ? nil : Constants.reviewNumberOfLines)
            HStack {
                Spacer()
                Button(action: toggleViewMore) {
                    if viewMore {
                        Label("View Less", systemImage: "arrowtriangle.up.square")
                    } else {
                        Label("View More", systemImage: "arrowtriangle.down.square")
                    }
                }
                .font(.callout)
            }
        }
        .padding(.vertical, 10)
        .onAppear(perform: getUserImage)
    }
    
    func toggleViewMore() {
        withAnimation(.easeInOut) {
            self.viewMore.toggle()
        }
    }
    
    func getUserImage() {
        guard let avatarURL = review.getAvatarURL() else {
            return
        }
        
        ImageDownloader.getImage(withURL: avatarURL) { image in
            if let image = image {
                self.avatarImage = Image(uiImage: image)
            }
        }
    }
}

struct ReviewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsRowView(review: MovieReviewViewModel.preview)
            .previewLayout(.sizeThatFits)
    }
}

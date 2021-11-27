//
//  ReviewRowView.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 27/11/21.
//

import SwiftUI

struct ReviewRowView: View {
    let authorName: String
    let authorImage: Image
    let date: Date
    let content: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                authorImage
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                    .layoutPriority(3)
                Text(authorName)
                    .font(Font.system(.title3, design: .rounded))
                    .layoutPriority(2)
                Spacer()
                Text(date.description)
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .layoutPriority(1)
            }
            Text(content)
        }
    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static let authorName: String = "Misael Very long long name"
    static let authorImage: Image = Image(systemName: "paperplane.fill")
    static let date = Date()
    static let content = "Great review, I would like to be more specific and with more drama, but that's ok for me, at least now. Thanks to the director"
    static var previews: some View {
        ReviewRowView(authorName: authorName, authorImage: authorImage, date: date, content: content)
    }
}

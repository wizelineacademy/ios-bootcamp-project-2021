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
        VStack {
            HStack {
                Text(authorName)
                authorImage
            }
            Text(content)
            HStack {
                Spacer()
                Text(date.description)
            }
        }

    }
}

struct ReviewRowView_Previews: PreviewProvider {
    static let authorName: String = "Misael"
    static let authorImage: Image = Image(systemName: "paperplane.fill")
    static let date = Date()
    static let content = "Great review"
    static var previews: some View {
        ReviewRowView(authorName: authorName, authorImage: authorImage, date: date, content: content)
    }
}

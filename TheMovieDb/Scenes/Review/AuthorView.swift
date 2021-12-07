//
//  AuthorView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/11/21.
//

import SwiftUI
import Kingfisher

struct AuthorView: View {
    
    private let baseUrl = "https://image.tmdb.org/t/p/w185"
    var author: AuthorDetail?
    
    var body: some View {
        HStack() {
            let urlString = "\(baseUrl)\(author?.avatarPath ?? "")"
            let image = UIImage.posterPlaceholder ?? UIImage()
            KFImage(URL(string: urlString))
                .placeholder({
                    Image(uiImage: image)
                })
                .resizable()
                .frame(width: 64, height: 64)
                .cornerRadius(32.0)
            VStack(spacing: 4) {
                if let authorName = author?.name,
                   !authorName.isEmpty {
                    Text(authorName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                if let username = author?.username,
                   !username.isEmpty {
                    Text(username)
                        .font(.footnote)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct AuthorView_Previews: PreviewProvider {
    
    static var previews: some View {
        let url: String = "/qGVhkysX35RprxjUHOI0vnFeeRc.jpg"
        let author = AuthorDetail(name: "Juan Alfredo",
                                  username: "Kayo",
                                  rating: 9.0,
                                  avatarPath: url)
        AuthorView(author: author)
    }
}

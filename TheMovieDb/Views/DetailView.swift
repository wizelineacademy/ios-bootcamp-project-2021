//
//  DetailView.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 27/11/21.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    var movieData: Movie?
    
    func buildBackdropImage() -> BackdropImage {
        var backdropImage = BackdropImage()
        if let backPath = movieData?.backdropPath {
            backdropImage.backdropPath = backPath
        }
        return backdropImage
    }
    
    func buildPosterImage () -> posterImage {
        var circlePosterImage = posterImage()
        if let posterPath = movieData?.posterPath {
            circlePosterImage.posterPath = posterPath
        }
        
        return circlePosterImage
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                buildBackdropImage()
                    .frame(height: 300, alignment: .top)
                buildPosterImage()
                    .offset(y: -130)
                    .padding(.bottom, -200)
                Text(movieData?.title ?? "Movie Title Placeholder")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.all)
                HStack {
                    Text("Rating:")
                    Text(Utils.showStar(value: Int(movieData?.voteAverage ?? 0.0)))
                    Spacer()
                    Text("Release:")
                    Text(movieData?.releaseDate?.readableDate() ?? "10 September 1992")
                }
                .padding(.bottom)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: UIScreen.main.bounds.width - 20)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width - 20)
                
                Text("Description")
                    .font(.title2)
                    .padding(.bottom)
                Text(movieData?.overview ?? "This is an overview Placeholder")
                    .multilineTextAlignment(.center)
                    .lineLimit(10)
                    .padding(.bottom)
                    .frame(width: UIScreen.main.bounds.width - 20)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .padding(.horizontal)
    }
}

struct BackdropImage: View {
    var backdropPath: String = String()
    var body: some View {
        let urlString = "\(Constants.URLS.imageURL)\(backdropPath)"
        KFImage(URL(string: urlString))
            .resizable()
            .scaledToFill()
    }
}

struct posterImage: View {
    var posterPath: String = String()
    var body: some View {
        let urlString = "\(Constants.URLS.imageURL)\(posterPath)"
        KFImage(URL(string: urlString))
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
            .shadow(radius: 7)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

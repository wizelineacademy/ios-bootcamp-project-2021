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
        
        backdropImage.backdropPath = movieData?.backdropPath ?? "https://www.themoviedb.org/t/p/w533_and_h300_bestv2/xikDpZZAQjzI2ZuaylyjNnOuhKF.jpg"
        
        return backdropImage
        
    }
    
    func buildCirclePosterImage () -> CirclePosterImage {
        var circlePosterImage = CirclePosterImage()
        
        circlePosterImage.posterPath = movieData?.posterPath ?? "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/jeggetf6lrd0dhtcbqJH75Sik4K.jpg"
        
        return circlePosterImage
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                buildBackdropImage()
                    .frame(height: 300, alignment: .top)
                buildCirclePosterImage()
                    .offset(y: -130)
                    .padding(.bottom, -200)
                Text(movieData?.originalTitle ?? "Movie Title Placeholder")
                    .font(.title)
                HStack{
                    Text("Rating:")
                    Text(showStar(value: Int(movieData?.voteAverage ?? 0.0)))
                    Text("Release:")
                    Text(movieData?.releaseDate?.readableDate() ?? "29 April 1992")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                Divider()
                
                Text("Description")
                    .font(.title2)
                Text(movieData?.overview ?? "This is an overview Placeholder")
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
            }
        }
        .frame(width: 400)
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

struct CirclePosterImage: View {
    var posterPath: String = String()
    var body: some View {
        let urlString = "\(Constants.URLS.imageURL)\(posterPath)"
        KFImage(URL(string:urlString))
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 350)
            .clipShape(Circle())
            .overlay(Circle().stroke(.gray, lineWidth: 1))
            .shadow(radius: 7)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

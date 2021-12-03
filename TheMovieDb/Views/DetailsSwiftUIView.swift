//
//  DetailsSwiftUIView.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 27/11/21.
//

import SwiftUI
import Kingfisher

struct DetailsSwiftUIView: View {
    var movie: Movie?
    @State var credits: [Cast] = []
    @State var similarMovies: [Movie] = []
    @State var collapsed: Bool = true
    let basePosterUrl = "https://image.tmdb.org/t/p/w500"
    init (movie: Movie?) {
        self.movie = movie
    }
    
    var body: some View {
        if let movie = movie {
            GeometryReader { g in
                ScrollView {
                     KFImage(URL(string: basePosterUrl + movie.posterPath!))
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(height: 350)
                         .background(Color.gray.opacity(0.4))
                     VStack(alignment: .leading) {
                         Text(movie.title)
                             .font(.title)
                         Text("Release date: " + movie.releaseDate)
                             .font(.caption)
                             .foregroundColor(.secondary)
                         Text("Overview")
                             .font(.headline)
                             .padding(.top)
                         Text(movie.overview)
                     }.padding()
                    
                    // Casting
                     List {
                         Section(header: ListHeader(collapsed: self.$collapsed, sectionName: "Cast")) {
                             ForEach(credits) { cast in
                                 HStack {
                                     Text(cast.name)
                                     Spacer()
                                     Text(cast.character)
                                 } .font(.footnote)
                             }
                             .transition(.slide)
                         }
                     }
                     .onAppear { getCast(movieId: movie.id) }
                     .listStyle(.plain)
                     .frame(width: g.size.width - 5, height: 400, alignment: .center)
                    
                    // Similar Movies
                    VStack(alignment: .leading) {
                        Text("Similar movies").font(.headline)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(similarMovies) { movie in
                                    VStack(spacing: 0) {
                                        KFImage(URL(string: basePosterUrl + movie.posterPath!))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .background(Color.gray.opacity(0.4))
                                        Text(movie.title)
                                            .padding(1)
                                            .frame(width: 150, height: 50, alignment: .top)
                                            .fixedSize(horizontal: false, vertical: true)
                                            .background(Color.black.opacity(0.6))
                                            .foregroundColor(.white)
                                            
                                    }
                                    .frame(width: 150)
                                }
                            } .onAppear { getSimilarMovies(movieId: movie.id) }
                        }
                    }
                    .padding()
                }
            }
            
        } else {
            Text("Movie not found")
        }
    }
    
    func getCast(movieId: Int) {
        if collapsed {
            let getCastRepo = GetCast()
            getCastRepo.getCredits(option: .cast(movieId: movieId)) { credits in
                self.credits.append(contentsOf: credits.cast)
            }
        } else {
            self.credits = []
        }
    }
    
    func getSimilarMovies(movieId: Int) {
        if collapsed {
            let getCastRepo = GetMovieList()
            getCastRepo.getMoviesList(option: .similarMovies(movieId: movieId)) { credits in
                self.similarMovies.append(contentsOf: credits.results)
            }
        } else {
            self.credits = []
        }
    }
    
    func toggleCredits(movieId: Int) {
        if credits.isEmpty {
            getCast(movieId: movieId)
        } else {
            credits = []
        }
    }
    
}

struct ListHeader: View {
    @Binding var collapsed: Bool
    var sectionName: String
    
    var body: some View {
        Button(
            action: { self.collapsed.toggle() },
            label: {
                HStack {
                    Text(sectionName)
                    Spacer()
                    Image(systemName: self.collapsed ? "chevron.down" : "chevron.up")
                }
                .padding(.bottom, 1)
                .background(Color.white.opacity(0.01))
                .foregroundColor(.primary)
                .font(.headline)
            }
        )
    }
}

struct DetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSwiftUIView(movie: nil)
    }
}

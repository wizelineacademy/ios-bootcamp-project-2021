//
//  MockService.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 16/11/21.
//

import Foundation
import Combine
@testable import TheMovieDb

final class MockService: MovieService {
    
    var failure = false
    private var cancellables = Set<AnyCancellable>()
    
    func get<T: Decodable>(type: T.Type, search: String?, endpoint: MovieListEndpoint) -> AnyPublisher<T, MovieError> {
        guard !failure else {
            return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
        }
        switch endpoint {
        case .trending, .nowPlaying, .popular, .topRated, .upcoming:
            guard let moviesResponse = mockedMovies() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(moviesResponse)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .search:
            guard let searchResponse = mockedSearchObject() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(searchResponse)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .movieDetails(_):
            guard let movieDetail = mockedMovies().results?[0] as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(movieDetail)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .personDetails(_):
            guard let personDetail = Person(id: 005, biography: "", knownForDepartment: "Actor", name: "Brad Pit", popularity: 5.1, profilePath: "", birthday: "", deathday: "") as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(personDetail)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .similar(_):
            guard let movieSimilar = mockedMovies() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(movieSimilar)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .recommendations(_):
            guard let movieRecomended = mockedMovies() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(movieRecomended)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .reviews(_):
            guard let reviewsResponse = mockedReview() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(reviewsResponse)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        case .credits(_):
            guard let creditsResponse = mockedCredits() as? T else {
                return Fail(error: MovieError.invalidResponse).eraseToAnyPublisher()
            }
            return Just(creditsResponse)
                .setFailureType(to: MovieError.self)
                .eraseToAnyPublisher()
        }
    }
    
    private func mockedMovies() -> MovieResponse<Movie> {
        return MovieResponse(page: 0,
                             results: [Movie(posterPath: "",
                                             overview: "",
                                             id: 001,
                                             originalTitle: "Dune",
                                             title: "Dune",
                                             originalLanguage: "en",
                                             popularity: 1.1,
                                             adult: false,
                                             releaseDate: "2021-09-30"),
                                       Movie(posterPath: "",
                                             overview: "",
                                             id: 002,
                                             originalTitle: "No time to die",
                                             title: "No time to die",
                                             originalLanguage: "en",
                                             popularity: 2.1,
                                             adult: false,
                                             releaseDate: "2021-10-30"),
                                       Movie(posterPath: "",
                                             overview: "",
                                             id: 003,
                                             originalTitle: "Eternals",
                                             title: "Eternals",
                                             originalLanguage: "en",
                                             popularity: 3.1,
                                             adult: false,
                                             releaseDate: "2021-11-01"),
                                       Movie(posterPath: "",
                                             overview: "",
                                             id: 004,
                                             originalTitle: "Venom: Let There Be Carnage",
                                             title: "Venom: Let There Be Carnage",
                                             originalLanguage: "en",
                                             popularity: 4.1,
                                             adult: false,
                                             releaseDate: "2021-09-20")],
                             totalPages: 1,
                             totalResults: 1)
    }
    
    private func mockedSearchObject() -> MovieResponse<SearchObject> {
        return MovieResponse(page: 0,
                             results: [SearchObject(id: 001,
                                                    name: nil,
                                                    title: "Dune",
                                                    mediaType: "movie"),
                                       SearchObject(id: 006,
                                                    name: nil,
                                                    title: "Betty la fea",
                                                    mediaType: "tv"),
                                       SearchObject(id: 005,
                                                    name: "Brad Pit",
                                                    title: nil,
                                                    mediaType: "person")],
                             totalPages: 1,
                             totalResults: 1)
    }
    
    private func mockedReview() -> MovieResponse<ReviewsDetails> {
        return MovieResponse(page: 0,
                             results: [ReviewsDetails(author: "Karla", content: "Excelent"),
                                      ReviewsDetails(author: "Daniela", content: "Bad movie")],
                             totalPages: 1,
                             totalResults: 1)
    }
    
    private func mockedCredits() -> CreditsMovie {
        return CreditsMovie(id: 1,
                            cast: [Person(id: 005,
                                          biography: "",
                                          knownForDepartment: "Actor",
                                          name: "Brad Pit",
                                          popularity: 5.1,
                                          profilePath: "",
                                          birthday: "",
                                          deathday: ""),
                                   Person(id: 007,
                                          biography: "",
                                          knownForDepartment: "Actor",
                                          name: "Keanu Revees",
                                          popularity: 7.1,
                                          profilePath: "",
                                          birthday: "",
                                          deathday: ""),
                                   Person(id: 008,
                                          biography: "",
                                          knownForDepartment: "Actress",
                                          name: "Jennifer Aniston",
                                          popularity: 8.1,
                                          profilePath: "",
                                          birthday: "",
                                          deathday: ""),
                                   Person(id: 009,
                                          biography: "",
                                          knownForDepartment: "Actress",
                                          name: "Angelina Jolie",
                                          popularity: 9.1,
                                          profilePath: "",
                                          birthday: "",
                                          deathday: "")],
                            crew: nil)
    }
    
}

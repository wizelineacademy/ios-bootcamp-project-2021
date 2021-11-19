//
//  MoviePresenter.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/12/21.
//

import Foundation

// MARK: class Presenter and protocols to manage the logic part of the app

protocol MoviePresenterDelegate: AnyObject {
  var complement: String? { get set }
  func showResults<Element: Decodable>(items: Element)
}

extension MoviePresenterDelegate {
  var complement: String? {
    get { return nil }
    set { _ = newValue }
  }
}

protocol MovieViewPresenter {
  init(view: MoviePresenterDelegate)
  func getData<Element: Decodable>(from: Endpoint, kindItem: Element.Type, complement: String?, search: String?)
}

class MoviePresenter: MovieViewPresenter {
  
  weak var view: MoviePresenterDelegate?
  var databaseManager = MovieDBClient.shared
  var movieDetails: MovieDetails?
  
  required init(view: MoviePresenterDelegate) {
    self.view = view
  }
  
  private func setUrl(_ from: Endpoint, search: String? = nil) -> URLRequest {
    let endPoint = from
    let query: [URLQueryItem]?
    
    if search != nil {
      query = [
        URLQueryItem(name: "query", value: search)
      ]
    } else { query = nil }
    
    let urlComponents = endPoint.getUrlComponents(queryItems: query)
    let request = endPoint.request(urlComponents: urlComponents)
    return request
  }
  
  func getData<Element: Decodable>(
    from: Endpoint,
    kindItem: Element.Type,
    complement: String? = nil,
    search: String? = nil) {
      
      let request = setUrl(from, search: search)
      
      databaseManager.fetch(with: request) { item -> Element in
        guard let items = item as? Element else { fatalError("problemms bringing the decodable json") }
        return items
      } completion: { [weak self] (result: Result<Element, ApiError>) in
        switch result {
        case .success(let element):
          if complement != nil {
            self?.view?.complement = complement!
            self?.view?.showResults(items: element)
          } else {
            self?.view?.showResults(items: element)
          }
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
}

// MARK: extension of movie presenter to get the data for completing the Movie details with reviews, cast, similar movies and recommended movies

extension MoviePresenter {
  
  func completeMovieDetails(movieDetails: MovieDetails, complete: @escaping (MovieDetails) -> Void) {
    self.movieDetails = movieDetails
    let movieId = movieDetails.id
    let group = DispatchGroup()
    for category in MovieSection.allCases {
      group.enter()
      if category == .cast {
        let request = setUrl(InfoById.credits(movieId))
        getDataDetailsMovie(request: request, kindItem: Credits.self, group: group) { [weak self] (credits, error) in
          guard let credits = credits else { return print(error!.localizedDescription as Any) }
          self?.movieDetails?.cast = credits.cast
        }
      } else if category == .reviews {
        let request = setUrl(InfoById.reviews(movieId))
        getDataDetailsMovie(request: request, kindItem: ListReviews.self, group: group) { [weak self] (listReviews, error) in
          guard let listReviews = listReviews else { return print(error!.localizedDescription as Any) }
          self?.movieDetails?.reviews = listReviews.results
        }
      } else if category == .similar {
        let request = setUrl(InfoById.similar(movieId))
        getDataDetailsMovie(request: request, kindItem: ListSimilarOrRecommendedMovies.self, group: group) { [weak self] (similarMovies, error) in
          guard let similarMovies = similarMovies else { return print(error!.localizedDescription as Any) }
          self?.movieDetails?.similarMovies = similarMovies.results
        }
      } else if category == .recommended {
        let request = setUrl(InfoById.recommendations(movieId))
        getDataDetailsMovie(request: request, kindItem: ListSimilarOrRecommendedMovies.self, group: group) { [weak self] (recommendedMovies, error) in
          guard let recommendedMovies = recommendedMovies else { return print(error!.localizedDescription as Any) }
          self?.movieDetails?.recommendedMovies = recommendedMovies.results
        }
      } else {
        group.leave()
      }
    }
    group.notify(queue: .main) {
      guard self.movieDetails != nil, let completeDetailMovie = self.movieDetails else { fatalError("problems settings reviews, cast, recommended")}
      complete(completeDetailMovie)
    }
  }
  
  private func getDataDetailsMovie<Element: Decodable>(request: URLRequest, kindItem: Element.Type, group: DispatchGroup, complete: @escaping (Element?, Error?) -> Void) {
    
    databaseManager.fetch(with: request) { json -> Element in
      guard let item = json as? Element else { fatalError("problem returning the json") }
      return item
    } completion: { (result: Result<Element, ApiError>) in
      switch result {
      case .success(let items):
        complete(items, nil)
        group.leave()
      case .failure(let error):
        complete(nil, error)
        group.leave()
      }
    }
  }
}

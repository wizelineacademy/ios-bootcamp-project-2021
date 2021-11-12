//
//  MoviePresenter.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/12/21.
//

import Foundation
import UIKit
import SwiftUI

protocol MoviePresenterDelegate: AnyObject {
  var complement: String? { get set }
  func showResults<Element: Decodable>(items: Element)
}

protocol MovieViewPresenter {
  init(view: MoviePresenterDelegate)
  func getData<Element: Decodable>(from: Endpoint, movieRegion: MovieRegion?, movieLanguage: MovieLanguage?, kindItem: Element.Type, complement: String?)
  
}

class MoviePresenter: MovieViewPresenter {
  
  weak var view: MoviePresenterDelegate?
  private var databaseManager = MovieDBClient.shared
  
  required init(view: MoviePresenterDelegate) {
    self.view = view
  }
  
  fileprivate func setUrl(_ from: Endpoint, _ movieRegion: MovieRegion?, _ movieLanguage: MovieLanguage?) -> URLRequest {
    let endPoint = from
    let query: [URLQueryItem]?
    
    if movieRegion != nil && movieLanguage != nil {
      query = [
        URLQueryItem(name: "language", value: movieLanguage?.language),
        URLQueryItem(name: "region", value: movieRegion?.region)
      ]
    } else {
      query = nil
    }
    
    let urlComponents = endPoint.getUrlComponents(queryItems: query)
    let request = endPoint.request(urlComponents: urlComponents)
    return request
  }
  
  func getData<Element: Decodable>(from: Endpoint, movieRegion: MovieRegion?, movieLanguage: MovieLanguage?, kindItem: Element.Type, complement: String?) {
    
    let request = setUrl(from, movieRegion, movieLanguage)
    
    databaseManager.fetch(with: request) { item -> Element in
      guard let items = item as? Element else { fatalError("problems bringing the decodable json") }
      return items
    } completion: { [weak self] (result: Result<Element, ApiError>) in
      switch result {
      case .success(let element):
        if complement != nil { self?.view?.complement = complement! }
        self?.view?.showResults(items: element)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

}

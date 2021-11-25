//
//  CastViewModel.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/21/21.
//
import UIKit
import Combine

struct PersonViewModel {
  
  private let person: Person
  
  init(person: Person) {
    self.person = person
  }
  
  var id: Int { person.id }
  
  var name: String { person.name }
  
  var character: String? { person.character }
  
  var profilePath: String? {
    let url: String?
    guard let portrait = person.profilePath else { return nil }
    url = ApiPath.baseUrlImage.path + portrait
    return url
  }
  
}

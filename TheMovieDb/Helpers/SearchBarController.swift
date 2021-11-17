//
//  SearchBarController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/15/21.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
  func searchBarTextDidEndEditing(_ searcBar: UISearchBar)
  func updateSearchResults(with text: String)
}

protocol SearchBarProtocol: UISearchBarDelegate & UISearchResultsUpdating {
  var text: String? { get set }
  var isSearchBarEmpty: Bool { get }
  var isFiltering: Bool { get }
  var showCancelButton: Bool { get set }
}

class SearchBarController: UISearchController, SearchBarProtocol {
  
  private weak var searchBarDelegate: SearchBarDelegate?
  
  public var text: String? {
    get {
      searchBar.text
    }
    set (newValue) {
      searchBar.text = newValue
    }
  }
  
  public var isSearchBarEmpty: Bool {
    return searchBar.text?.isEmpty ?? true
  }
  
  public var isFiltering: Bool {
    isActive && !isSearchBarEmpty
  }
  
  public var showCancelButton: Bool = false {
    didSet {
      searchBar.showsCancelButton = showCancelButton
    }
  }
  
  init(placeholder: String?, delegate: SearchBarDelegate?) {
    self.searchBarDelegate = delegate
    super.init(searchResultsController: nil)
    self.obscuresBackgroundDuringPresentation = true
    self.searchResultsUpdater = self
    searchBar.delegate = self
    searchBar.showsCancelButton = false
    searchBar.placeholder = placeholder
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    showCancelButton = true
    searchBarDelegate?.searchBarTextDidBeginEditing(searchBar)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    showCancelButton = !isSearchBarEmpty
    searchBarDelegate?.searchBarTextDidEndEditing(searchBar)
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    searchBarDelegate?.updateSearchResults(with: text ?? "")
  }

}

//
//  SearchBar.swift
//  TheMovieDb
//
//  Created by Misael Chávez on 01/12/21.
//

import UIKit

protocol SearchBarDelegate: AnyObject {
    func searchBarCancelledButton(_ searchBar: UISearchBar)
    func updateSearchResults(for text: String)
}

protocol SearchBarProtocol: UISearchBarDelegate & UISearchResultsUpdating {

    var text: String? { get set }
    var isSearchBarEmpty: Bool { get }
    var showsCancelButton: Bool { get set }
}

class SearchBar: UISearchController, SearchBarProtocol {

    private weak var searchBarDelegate: SearchBarDelegate?

    public var text: String? {
        get {
            searchBar.text
        }
        set {
            searchBar.text = newValue
        }
    }

    public var isSearchBarEmpty: Bool {
        searchBar.text?.isEmpty ?? true
    }

    public var showsCancelButton: Bool = false {
        didSet {
            searchBar.showsCancelButton = showsCancelButton
        }
    }

    init(_ placeholder: String?, delegate: SearchBarDelegate?) {
        self.searchBarDelegate = delegate
        super.init(searchResultsController: nil)
        self.obscuresBackgroundDuringPresentation = false
        self.searchResultsUpdater = self
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = placeholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        showsCancelButton = !isSearchBarEmpty
    }

    func updateSearchResults(for searchController: UISearchController) {
        searchBarDelegate?.updateSearchResults(for: text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBarDelegate?.searchBarCancelledButton(searchBar)
    }
}

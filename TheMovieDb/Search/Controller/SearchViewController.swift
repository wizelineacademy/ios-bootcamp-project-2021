//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

private let reuserIdentifier = "SearchCell"
final class SearchViewController: UITableViewController {
 
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)

    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
       
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuserIdentifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.title = "Hello there!"
        definesPresentationContext = false
    }
    
    // MARK: - API
    
}

// MARK: - UITableViewDataSource
extension SearchViewController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? 2 : 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuserIdentifier, for: indexPath)
        cell.textLabel?.text = ":)"
       
        return cell
    }
}

// MARK: - UITableDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else {return}
        print(searchText)
        self.tableView.reloadData()
    }
    
}

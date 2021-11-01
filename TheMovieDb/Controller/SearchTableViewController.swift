//
//  SearchTableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var searchResult: [SearchObject] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for movies or person"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func searchObjects(with text: String) {
        MovieFacade.get(search: text, endpoint: .search) { [weak self] (response: Result<MovieResponse<SearchObject>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                guard let resultObject = movieResponse.results else { return }
                for object in resultObject {
                    if object.mediaType != "tv" {
                        self.searchResult.append(object)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSearch", for: indexPath)
        let row = searchResult[indexPath.row]
        if let mediaType = row.mediaType, let type = MediaType(rawValue: mediaType) {
            switch type {
            case .movie:
                cell.textLabel?.text = row.title
            case .person:
                cell.textLabel?.text = row.name
            case .tv:
                print("Not considered media type")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchObjectSelected = searchResult[indexPath.row]
        if let mediaType = searchObjectSelected.mediaType, let type = MediaType(rawValue: mediaType) {
            switch type {
            case .person:
                if let vcPersonSelected = storyboard?.instantiateViewController(withIdentifier: "PersonDetail") as? PersonDetailViewController {
                    guard let idSelected = searchObjectSelected.id else { return }
                    vcPersonSelected.personID = idSelected
                    navigationController?.pushViewController(vcPersonSelected, animated: true)
                }
            case .movie:
            if let vcMovieSelected = storyboard?.instantiateViewController(identifier: "MovieInfo") as? MovieInfoViewController {
                guard let idSelected = searchObjectSelected.id else { return }
                vcMovieSelected.movieID = idSelected
                navigationController?.pushViewController(vcMovieSelected, animated: true)
            }
            case .tv:
                return
            }
        }
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text else { return }
        searchObjects(with: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

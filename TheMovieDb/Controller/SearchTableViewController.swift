//
//  SearchTableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

final class SearchTableViewController: UITableViewController {

    var searchResult: [SearchObject] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupNavigation()
    }
    
    func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
    }
    
    func setupNavigation() {
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
                var searchArray: [SearchObject] = []
                for object in resultObject {
                    if object.mediaType != "tv" {
                        searchArray.append(object)
                    }
                }
                self.searchResult = searchArray
            case .failure(let error):
                print(error.localizedDescription)
                self.showErrorAlert()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let row = searchResult[indexPath.row]
        if let mediaType = row.mediaType, let type = MediaType(rawValue: mediaType) {
            cell.detailTextLabel?.text = mediaType
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
        guard let idSelected = searchObjectSelected.id else { return }
        if let mediaType = searchObjectSelected.mediaType, let type = MediaType(rawValue: mediaType) {
            switch type {
            case .person:
                navigationPersonDetailViewController(id: idSelected)
            case .movie:
                navigationPersonDetailViewController(id: idSelected)
            case .tv:
                return
            }
        }
    }
    
    func navigationPersonDetailViewController(id: Int) {
        if let PersonDetailViewController = storyboard?.instantiateViewController(withIdentifier: Constants.personDetailViewControllerID) as? PersonDetailViewController {
            PersonDetailViewController.personID = id
            navigationController?.pushViewController(PersonDetailViewController, animated: true)
        }
    }
    
    func navigationMovieInfoViewController(id: Int) {
        if let MovieInfoViewController = storyboard?.instantiateViewController(withIdentifier: Constants.movieInfoViewControllerID) as? MovieInfoViewController {
            MovieInfoViewController.movieID = id
            navigationController?.pushViewController(MovieInfoViewController, animated: true)
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
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: Constants.errorAlertTitle, message: Constants.errorAlertMessage, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: Constants.errorAlertButton, style: .default))
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true)
        }
    }
}

//
//  SearchTableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit

final class SearchViewModel {
    
    var loadSearch: (() -> Void)?
    var searchResult: [SearchObject] = [] {
        didSet {
            DispatchQueue.main.async {
                self.loadSearch?()
            }
        }
    }
    
    var facade: MovieService
    init(facade: MovieService) {
        self.facade = facade
    }
    
    var showError: ((MovieError) -> Void)?
    
    func searchObjects(with text: String) {
        facade.get(search: text, endpoint: .search) { [weak self] (response: Result<MovieResponse<SearchObject>, MovieError>) in
            guard let self = self else { return }
            
            switch response {
            case .success(let movieResponse):
                guard let resultObject = movieResponse.results else {
                    self.showError?(.invalidResponse)
                    return
                }
                var searchArray: [SearchObject] = []
                for object in resultObject {
                    if object.mediaType != "tv" {
                        searchArray.append(object)
                    }
                }
                self.searchResult = searchArray
            case .failure(let failureResult):
                self.showError?(failureResult)
            }
        }
    }
}

final class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewModel = .init(facade: MovieFacade())
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewUI()
        setupSearchController()
        setupNavigation()
        viewModel.loadSearch = { [weak self] in self?.tableView.reloadData() }
        viewModel.showError = { [weak self] error in self?.showErrorAlert(error) }
    }
    
    func setupTableViewUI() {
        tableView.register(SearchSubtitleTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let row = viewModel.searchResult[indexPath.row]
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
        let searchObjectSelected = viewModel.searchResult[indexPath.row]
        guard let idSelected = searchObjectSelected.id else { return }
        if let mediaType = searchObjectSelected.mediaType, let type = MediaType(rawValue: mediaType) {
            switch type {
            case .person:
                navigationPersonDetailViewController(id: idSelected)
            case .movie:
                navigationMovieInfoViewController(id: idSelected)
            case .tv:
                return
            }
        }
    }
    
    func navigationPersonDetailViewController(id: Int) {
        let PersonDetailViewController = PersonDetailViewController()
        PersonDetailViewController.viewModel.personID = id
        navigationController?.pushViewController(PersonDetailViewController, animated: true)
    }
    
    func navigationMovieInfoViewController(id: Int) {
        let MovieInfoViewController = MovieInfoViewController()
        MovieInfoViewController.viewModel.movieID = id
        navigationController?.pushViewController(MovieInfoViewController, animated: true)
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text, !text.isEmpty else {
            viewModel.searchResult.removeAll()
            return
        }
        viewModel.searchObjects(with: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchResult.removeAll()
    }
}

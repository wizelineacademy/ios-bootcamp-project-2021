//
//  SearchTableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 31/10/21.
//

import UIKit
import os.log

final class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchViewModel?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    init(facade: MovieService) {
        super.init(nibName: nil, bundle: nil)
        viewModel = SearchViewModel(facade: facade)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewUI()
        setupSearchController()
        setupNavigation()
        viewModel?.loadSearch = { [weak self] in self?.tableView.reloadData() }
        viewModel?.showError = { [weak self] error in self?.showErrorAlert(error) }
        os_log("SearchTableViewController did load!", log: OSLog.viewCycle, type: .debug)
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
        return viewModel?.searchResult.count ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let row = viewModel?.searchResult[indexPath.row]
        if let mediaType = row?.mediaType, let type = MediaType(rawValue: mediaType) {
            cell.detailTextLabel?.text = mediaType.localized
            switch type {
            case .movie:
                cell.textLabel?.text = row?.title
            case .person:
                cell.textLabel?.text = row?.name
            case .tv:
                print("Not considered media type")
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchObjectSelected = viewModel?.searchResult[indexPath.row]
        guard let idSelected = searchObjectSelected?.id else { return }
        if let mediaType = searchObjectSelected?.mediaType, let type = MediaType(rawValue: mediaType) {
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
        let PersonDetailViewController = PersonDetailViewController(facade: MovieFacade())
        PersonDetailViewController.viewModel?.personID = id
        navigationController?.pushViewController(PersonDetailViewController, animated: true)
    }
    
    func navigationMovieInfoViewController(id: Int) {
        let MovieInfoViewController = MovieInfoViewController(facade: MovieFacade())
        MovieInfoViewController.viewModel?.movieID = id
        navigationController?.pushViewController(MovieInfoViewController, animated: true)
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        
        guard let text = searchBar.text, !text.isEmpty else {
            viewModel?.searchResult.removeAll()
            return
        }
        viewModel?.searchObjects(with: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.searchResult.removeAll()
    }
}

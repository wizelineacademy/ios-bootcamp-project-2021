//
//  SearchingView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class SearchingView: UIViewController {

    // MARK: Properties
    var presenter: SearchingPresenterProtocol?
    private var tableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: [MovieViewModel] = []

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
}

// MARK: Helpers
private extension SearchingView {
    func configureUI() {
        configureTableView()
        configureSearchController()

    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reusableIdentifier)
        tableView.rowHeight = 64
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView?.isHidden = true
        definesPresentationContext = false
    }
}

// MARK: - UITableDelegate
extension SearchingView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie =  viewModel[indexPath.row].movie
        presenter?.showMovie(movie)
    }
}

// MARK: - UITableViewDataSource
extension SearchingView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reusableIdentifier, for: indexPath) as? SearchCell else {
            return SearchCell()
        }
        let viewModel = viewModel[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchingView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter?.searchMovies(text)
    }
}

extension SearchingView: SearchingViewProtocol {
    func showMoviesResults(_ moviesFound: [MovieViewModel]) {
        viewModel = moviesFound
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showSpinnerView() {
        showSpinner(onView: view)
    }
    
    func stopSpinnerView() {
        removeSpinner()
    }
    
}

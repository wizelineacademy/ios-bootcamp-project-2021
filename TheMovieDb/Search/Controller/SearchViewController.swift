//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit

final class SearchViewController: UITableViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "SearchCell"
    private let searchController = UISearchController(searchResultsController: nil)
    private var moviesSearch: [Movie] = []
    public let searchData: SearchingDataProtocol
    private let globalTread = DispatchQueue.global(qos: .userInitiated)
    
    // MARK: - Life Cycle
    init(searchData: SearchingDataProtocol ) {
        let style = UITableView.Style.insetGrouped
        self.searchData = searchData
        super.init(style: style )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        searchData.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    // MARK: - Helpers
    
    func configureTableView() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reusableIdentifier)
        tableView.rowHeight = 64
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.titleView?.isHidden = true
        definesPresentationContext = false
        
    }
    
    // MARK: - API
    
}

// MARK: - UITableViewDataSource
extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesSearch.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reusableIdentifier, for: indexPath) as? SearchCell else {
            return SearchCell()
        }
        let movie = moviesSearch[indexPath.row]
        let viewModel = MovieViewModel(movie: movie)
        cell.viewModel = viewModel
        return cell
    }
}

// MARK: - UITableDelegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie =  moviesSearch[indexPath.row]
        let controller = DetailViewController(with: movie)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}
        let parameter = APIParameters(query: text)
        showSpinner(onView: self.view)
        globalTread.async {
            self.searchData.getMovie(with: parameter)
        }
       
    }
}

extension SearchViewController: GetMoviesDelegate {
    func didGetMovies(movies: [Movie]) {
        self.moviesSearch = movies
        self.removeSpinner()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

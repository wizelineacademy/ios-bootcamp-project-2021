//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 19/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    private var searchViewModel = SearchViewModel()
    
    init(searchViewModel: SearchViewModel = SearchViewModel()) {
        self.searchViewModel = searchViewModel
        super.init(nibName: Constants.searchViewControllerName, bundle: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: Constants.cellXibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
        
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchViewModel.searchMovie(with: searchBar.text) { [weak self] in
            self?.searchTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let movie = searchViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: Constants.detailViewControllerName) as? DetailViewController else { return }
        detailViewController.movieData = searchViewModel.cellForRowAt(indexPath: indexPath)
        show(detailViewController, sender: self)
    }
}

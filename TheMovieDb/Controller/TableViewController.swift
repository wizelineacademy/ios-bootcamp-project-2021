//
//  TableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit

final class TableViewController: UITableViewController {
    
    var moviesCategory: [(name: String, type: MovieListEndpoint)] = [("Trending", .trending),
                                        ("Now Playing", .nowPlaying),
                                        ("Popular", .popular),
                                        ("Top Rated", .topRated),
                                        ("Upcoming", .upcoming)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.titleInitialTableView
        setupNavigationBar()
        setupTableViewUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupTableViewUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = moviesCategory[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerMoviesList = ViewController()
        let category = moviesCategory[indexPath.row]
        viewControllerMoviesList.type = category.type
        viewControllerMoviesList.typeTitle = category.name
        navigationController?.pushViewController(viewControllerMoviesList, animated: true)
    }
    
    @objc func searchTapped() {
        let searchTableViewController = SearchTableViewController()
        navigationController?.pushViewController(searchTableViewController, animated: true)
    }
}

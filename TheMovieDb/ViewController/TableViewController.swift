//
//  TableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit

final class TableViewController: UITableViewController {
    
    var viewModel: MoviesOptionsViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
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
        return viewModel.movieOptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.movieOptions[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerMoviesList = ViewController()
        let category = viewModel.movieOptions[indexPath.row]
        viewControllerMoviesList.viewModel.movieListOption = category
        navigationController?.pushViewController(viewControllerMoviesList, animated: true)
    }
    
    @objc func searchTapped() {
        let searchTableViewController = SearchTableViewController()
        navigationController?.pushViewController(searchTableViewController, animated: true)
    }
}

//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit
import os.log

final class ViewController: UIViewController {
    
    private var presenter: MovieListPresenter?
    private var movieListOption: MoviesOptions = .nowPlaying
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureTableView()
        configureUI()
        setupNavigationBar()
        presenter = MovieListPresenter(view: self as MovieListView, facade: MovieFacade(), movieOption: movieListOption)
        presenter?.listMovies()
        os_log("ViewController did load!", log: OSLog.viewCycle, type: .debug)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    private func configureUI() {
        title = presenter?.movieListOption.title
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.movies.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = presenter?.movies[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerMovieInfo = MovieInfoViewController()
        viewControllerMovieInfo.viewModel.movieID = presenter?.movies[indexPath.row].id
        navigationController?.pushViewController(viewControllerMovieInfo, animated: true)
    }
}

extension ViewController: MovieListView {
    func showError(_ error: MovieError) {
        showErrorAlert(error)
    }
    
    func didSetTitle(title: String) {
        self.title = title
    }
   
    
    func onUpdateMovies() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


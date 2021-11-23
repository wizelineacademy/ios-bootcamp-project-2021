//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ListViewController: UIViewController {

    lazy private var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .systemIndigo
        return view
    }()
    
    // general margin for ui elements
    private let margin: CGFloat = 10
    
    private var listView: ListView!
    private var listViewModel: ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tabIndex = self.tabBarController?.selectedIndex, let movieFeed = MovieFeed(rawValue: tabIndex) else {
            return
        }
        let movieAPIManager = MovieAPIManager(client: MovieAPIClient())
        let model = MovieModel(movieManager: movieAPIManager)
        listViewModel = ListViewModel(movieModel: model, movieFeed: movieFeed, delegate: self)
        listView = ListView(viewModel: listViewModel, navigationDelegate: self)
        
        setupUI(movieFeed: movieFeed)
    }
    
    private func setupUI(movieFeed: MovieFeed) {
        
        view.addSubview(listView.collectionView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            listView.collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            listView.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = movieFeed.getNavigationTitle()

        // Customize navigation bar.
        guard let navbar = self.navigationController?.navigationBar else { return }

        navbar.tintColor = .systemIndigo
        navbar.largeTitleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.titleTextAttributes = [.foregroundColor: UIColor.systemIndigo]
        navbar.prefersLargeTitles = true
        
        // Customize tab bar
        guard let tabBar = self.tabBarController?.tabBar else {
            return
        }
        
        tabBar.tintColor = .systemIndigo
    }
    
}

// MARK: - UI Updates
extension ListViewController: ListViewModelDelegate {
    func didBeginRefreshing() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func didEndRefreshing() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        listView?.collectionView.refreshControl?.endRefreshing()
        listView?.collectionView.reloadData()
    }
}

// MARK: - Navigation
extension ListViewController: NavigationDelegate {
    func navigate(movieViewModel: MovieViewModel) {
        let detailViewController = DetailViewController()
        detailViewController.movieViewModel = movieViewModel
        guard let navigation = navigationController else {
            return
        }
        navigation.showDetailViewController(detailViewController, sender: self)
    }
}

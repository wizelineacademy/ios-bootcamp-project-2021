//
//  SearchSceneViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import UIKit
import Combine

protocol SearchSceneViewControllerInput: AnyObject {
    func showSearchResult(page: PageModel<MovieModel>)
    func showErrorMessage(message: String)
}

protocol SearchSceneViewControllerOutput: AnyObject {
    func callToSearchQuery(query: String)
    func resetCounter()
}

final class SearchSceneViewController: UICollectionViewController {
    
    var interactor: SearchSceneInteractorInput?
    var router: SearchSceneRoutingLogic?
    private var searchQuery: String = ""
    
    private var isPaginationEnabled: Bool = true
    private var items: [MovieModel] = []
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    init() {
        let identifier = String(describing: SearchSceneViewController.self)
        super.init(nibName: identifier, bundle: Bundle.main)
        tabBarItem.title = "Search"
        tabBarItem.image = UIImage.search
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchCell.self,
                                forCellWithReuseIdentifier: SearchCell.cellIdentifier)
        collectionView.collectionViewLayout = SearchFlowLayout()
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SearchCell = collectionView.reuse(identifier: SearchCell.cellIdentifier,
                                                    for: indexPath)
        cell.movie = items[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SearchCell {
            let movie = items[indexPath.row]
            cell.movie = movie
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {
            if !isPaginationEnabled {
                isPaginationEnabled = true
                interactor?.callToSearchQuery(query: searchQuery)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = items[indexPath.row]
        router?.showDetailMovie(movie)
    }
}

extension SearchSceneViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.resetCounter()
        self.items = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        searchQuery = searchBar.text ?? ""
        interactor?.callToSearchQuery(query: searchQuery)
    }
}

extension SearchSceneViewController: SearchSceneViewControllerInput {
    
    func showSearchResult(page: PageModel<MovieModel>) {
        isPaginationEnabled = false
        items.append(contentsOf: page.results)
        collectionView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        router?.showToast(message: message)
    }
}

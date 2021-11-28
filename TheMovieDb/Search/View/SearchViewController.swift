//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 02/11/21.
//

import UIKit
import Combine

final class SearchViewController: UICollectionViewController {
    
    private var isPaginationEnabled: Bool = true
    private let executor: ExecutorRequest = NetworkAPI()
    private var request: (Request & SearchableModel & PageableModel)? = SearchRequest()
    private var totalOfPages: Int = 1
    private var items: [MovieModel] = []
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                request?.nextPage()
                callService()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = items[indexPath.row]
        let factory = DefaultDetailSceneFactory()
        factory.configurator = DefaultDetailSceneConfigurator()
        let viewController = factory.makeDetailScene(movie: movie)
        viewController?.hidesBottomBarWhenPushed = true
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

private extension SearchViewController {
    
    func callService() {
        guard let actualPage = request?.page,
                actualPage <= totalOfPages else { return }
        executor.execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Toast.showToast(title: error.localizedDescription)
                default:
                    return
                }
            }, receiveValue: { [weak self] (response: PageModel<MovieModel>?) in
                self?.onSuccessResponse(response)
            }).store(in: &cancellables)
    }
    
    func onSuccessResponse(_ response: PageModel<MovieModel>?) {
        isPaginationEnabled = false
        totalOfPages = response?.totalPages ?? 0
        items.append(contentsOf: response?.results ?? [])
        collectionView.reloadData()
    }
    
    func onErrorResponse(_ error: Error?) {
        isPaginationEnabled = false
        Toast.showToast(title: error?.localizedDescription ?? "")
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.totalOfPages = 1
        self.items = []
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        request?.clearPages()
        request?.searchText(searchBar.text ?? "")
        callService()
    }
}

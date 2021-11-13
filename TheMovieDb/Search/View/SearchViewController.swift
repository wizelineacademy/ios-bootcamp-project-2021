//
//  SearchViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 02/11/21.
//

import UIKit

final class SearchViewController: UICollectionViewController {
    
    private var isPaginationEnabled: Bool = true
    private var request: (Request & SearchableModel & PageableModel)? = SearchRequest()
    private var totalOfPages: Int = 1
    private var items: [MovieModel] = []
    
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
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: SearchCell.cellIdentifier,
                                     for: indexPath) as? SearchCell else {
                    return UICollectionViewCell()
                }
        let movie = items[indexPath.row]
        cell.movie = movie
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
    
    @IBSegueAction func goToDetailActionSegue(_ coder: NSCoder, sender: Any?) -> DetailViewController? {
        guard let cell = sender as? SearchCell,
              let movie = cell.movie else {
                  return nil
              }
        return DetailViewController(movie: movie, coder: coder)
    }
}

private extension SearchViewController {
    
    func callService() {
        guard let actualPage = request?.page,
                actualPage <= totalOfPages else { return }
        NetworkAPI
            .shared
            .execute(request: request,
                     onSuccess: { [weak self] (data: PageModel<MovieModel>?) in
                self?.onSuccessResponse(data)
            }, onError: { [weak self] error in
                self?.onErrorResponse(error)
            })
    }
    
    func onSuccessResponse(_ response: PageModel<MovieModel>?) {
        DispatchQueue.main.async {
            self.isPaginationEnabled = false
            self.totalOfPages = response?.totalPages ?? 0
            self.items.append(contentsOf: response?.results ?? [])
            self.collectionView.reloadData()
        }
    }
    
    func onErrorResponse(_ error: Error?) {
        DispatchQueue.main.async {
            self.isPaginationEnabled = false
            Toast.showToast(title: error?.localizedDescription ?? "")
        }
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

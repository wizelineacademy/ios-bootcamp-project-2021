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
        collectionView.collectionViewLayout = ListSectionFlowLayout()
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ListSectionCell.identifier,
                                     for: indexPath) as? ListSectionCell else {
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
        if let cell = cell as? ListSectionCell {
            let movie = items[indexPath.row]
            cell.movie = movie
        }
    }
    
    private func callService() {
        guard let actualPage = request?.page,
                actualPage <= totalOfPages else { return }
        NetworkAPI
            .shared
            .execute(request: request!,
                     onSuccess: { [weak self] (data: PageModel?) in
                self?.isPaginationEnabled = false
                self?.totalOfPages = data?.totalPages ?? 0
                self?.items.append(contentsOf: data?.results ?? [])
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }, onError: { [weak self] error in
                self?.isPaginationEnabled = false
                print(error?.localizedDescription)
            })
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

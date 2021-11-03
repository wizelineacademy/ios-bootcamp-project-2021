//
//  ListSectionViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import UIKit

final class ListSectionViewController: UICollectionViewController {
    
    static let segueIdentifier: String = "go-to-list-section"
    private var isPaginationEnabled: Bool = true
    private var request: (Request & PageableModel)?
    var section: HomeSections? {
        didSet {
            request = section?.request
        }
    }
    
    private var items: [MovieModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.addTarget(self, action: #selector(clearList), for: .valueChanged)
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = section?.title
        collectionView.refreshControl = refreshControl
        collectionView.collectionViewLayout = ListSectionFlowLayout()
        callService()
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
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ListSectionCell {
            let movie = items[indexPath.row]
            cell.movie = movie
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if collectionView.contentOffset.y >=
            (collectionView.contentSize.height - collectionView.bounds.size.height) {
            if !isPaginationEnabled {
                isPaginationEnabled = true
                callService()
            }
        }
    }
    
    @objc private func clearList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.items = []
            self.request?.clearPages()
            self.collectionView.reloadData()
            self.callService()
        }
    }

    private func callService() {
        NetworkAPI
            .shared
            .execute(request: self.request,
                     onSuccess: { [weak self] (response: PageModel?) in
                self?.request?.nextPage()
                self?.isPaginationEnabled = false
                self?.items.append(contentsOf: response?.results ?? [])
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    self?.collectionView.reloadData()
                }
            }, onError: { [weak self] error in
                self?.isPaginationEnabled = false
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    
                }
        })
    }
}

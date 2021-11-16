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
    
    private let navigationTitle: String
    private var request: (Request & PageableModel)?
    
    private var items: [MovieModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.addTarget(self, action: #selector(clearList), for: .valueChanged)
        return refresh
    }()
    
    init?(title: String, request: (Request & PageableModel)?, coder: NSCoder) {
        self.navigationTitle = title
        self.request = request
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = navigationTitle
        collectionView.refreshControl = refreshControl
        collectionView.collectionViewLayout = ListSectionFlowLayout()
        callService()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ListSectionCell = collectionView.reuse(identifier: ListSectionCell.identifier,
                                                         for: indexPath)
        cell.movie = items[indexPath.row]
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
    
    @IBSegueAction func goToDetailActionSegue(_ coder: NSCoder, sender: Any?) -> DetailViewController? {
        guard let cell = sender as? ListSectionCell,
              let item = cell.movie else {
                  return nil
              }
        return DetailViewController(movie: item, coder: coder)
    }
}

private extension ListSectionViewController {
    
    func callService() {
        NetworkAPI
            .shared
            .execute(request: self.request,
                     onSuccess: { [weak self] (response: PageModel<MovieModel>?) in
                self?.onSuccessResponse(response)
            }, onError: { [weak self] error in
                self?.onErrorResponse(error)
        })
    }
    
    func onSuccessResponse(_ response: PageModel<MovieModel>?) {
        DispatchQueue.main.async {
            self.request?.nextPage()
            self.isPaginationEnabled = false
            self.items.append(contentsOf: response?.results ?? [])
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
    }
    
    func onErrorResponse(_ error: Error?) {
        DispatchQueue.main.async {
            self.isPaginationEnabled = false
            self.refreshControl.endRefreshing()
            guard let error = error as? NetworkError else {
                return
            }
            Toast.showToast(title: error.localizedDescription)
        }
    }
}

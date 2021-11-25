//
//  ListSectionViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 30/10/21.
//

import UIKit
import Combine

final class ListSectionViewController: UICollectionViewController {
    
    static let segueIdentifier: String = "go-to-list-section"
    
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private let executor: ExecutorRequest
    private var isPaginationEnabled: Bool = true
    private let navigationTitle: String
    private var request: (Request & PageableModel)?
    private var items: [MovieModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.addTarget(self, action: #selector(clearList), for: .valueChanged)
        return refresh
    }()
    
    init?(title: String,
          executor: ExecutorRequest = NetworkAPI(),
          request: (Request & PageableModel)?, coder: NSCoder) {
        self.navigationTitle = title
        self.executor = executor
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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = items[indexPath.row]
        let factory = DefaultDetailSceneFactory()
        factory.configurator = DefaultDetailSceneConfigurator()
        let viewController = factory.makeDetailScene(movie: movie)
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension ListSectionViewController {
    
    func callService() {
        executor.execute(request: self.request)
            .receive(on: DispatchQueue.main)
            .sink { (response: PageModel<MovieModel>?) in
                self.onSuccessResponse(response)
            }.store(in: &cancellables)
    }
    
    func onSuccessResponse(_ response: PageModel<MovieModel>?) {
        request?.nextPage()
        isPaginationEnabled = false
        items.append(contentsOf: response?.results ?? [])
        refreshControl.endRefreshing()
        collectionView.reloadData()
    }
    
    func onErrorResponse(_ error: Error?) {
        isPaginationEnabled = false
        refreshControl.endRefreshing()
        guard let error = error as? NetworkError else {
            return
        }
        Toast.showToast(title: error.localizedDescription)
    }
}

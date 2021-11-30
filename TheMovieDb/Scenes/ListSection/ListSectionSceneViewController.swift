//
//  ListSectionSceneViewController.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 28/11/21.
//

import UIKit
import Combine

protocol ListSectionSceneViewControllerInput: AnyObject {
    func showResults(page: PageModel<MovieModel>)
    func showErrorMessage(message: String)
}

protocol ListSectionSceneViewControllerOutput: AnyObject {
    func callSectionQuery()
    func resetCounter()
}

final class ListSectionSceneViewController: UICollectionViewController {
    
    var interactor: ListSectionSceneInteractorInput?
    var router: ListSectionSceneRoutingLogic?
    
    private var isPaginationEnabled: Bool = true
    private let navigationTitle: String
    private var items: [MovieModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.addTarget(self, action: #selector(clearList), for: .valueChanged)
        return refresh
    }()
    
    init(section: HomeSections) {
        let identifier = String(describing: ListSectionSceneViewController.self)
        self.navigationTitle = section.title
        super.init(nibName: identifier, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ListSectionCell.self, forCellWithReuseIdentifier: ListSectionCell.identifier)
        navigationItem.title = navigationTitle
        collectionView.refreshControl = refreshControl
        collectionView.collectionViewLayout = ListSectionFlowLayout()
        interactor?.callSectionQuery()
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
                interactor?.callSectionQuery()
            }
        }
    }
    
    @objc private func clearList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.items = []
            self.interactor?.resetCounter()
            self.collectionView.reloadData()
            self.interactor?.callSectionQuery()
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

extension ListSectionSceneViewController: ListSectionSceneViewControllerInput {
   
    func showResults(page: PageModel<MovieModel>) {
        isPaginationEnabled = false
        items.append(contentsOf: page.results)
        collectionView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        router?.showToast(message: message)
    }
}

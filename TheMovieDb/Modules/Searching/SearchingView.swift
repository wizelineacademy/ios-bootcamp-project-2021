//
//  SearchingView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

final class SearchingView: UICollectionViewController, DisplayError, DisplaySpinner, DisplayMessage {

    // MARK: Properties
    var presenter: SearchingPresenterProtocol?
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: [MovieViewModel] = []

    // MARK: Lifecycle
    init(layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
}

// MARK: Helpers
private extension SearchingView {
    func configureUI() {
        configureCollectionView()
        configureSearchController()

    }
    
    func configureCollectionView() {
        collectionView.register(DefaultSectionCell.self, forCellWithReuseIdentifier: DefaultSectionCell.reusableIdentifier)
        collectionView.keyboardDismissMode = .interactive
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = InterfaceConst.search
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView?.isHidden = true
        definesPresentationContext = false
    }
}

// MARK: - UITCollectionViewControllerDelegate
extension SearchingView {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie =  viewModel[indexPath.row].movie
        presenter?.showMovie(movie)
    }
}

// MARK: - UITCollectionViewControllerDataSource
extension SearchingView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultSectionCell.reusableIdentifier, for: indexPath) as? DefaultSectionCell else {
            return DefaultSectionCell()
        }
        let viewModel = viewModel[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchingView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(
            top: InterfaceConst.initZeroValue,
            left: InterfaceConst.paddingPrimaryValue,
            bottom: InterfaceConst.initZeroValue,
            right: InterfaceConst.paddingPrimaryValue
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var defaultSize: CGSize = .init(
            width: (view.frame.width - InterfaceConst.widthMovieCellMinus) / InterfaceConst.divideInto3,
            height: view.frame.height * InterfaceConst.heightMovieCell
        )
        if UIDevice.current.userInterfaceIdiom == .pad {
            defaultSize = .init(
                width: (view.frame.width - InterfaceConst.widthMovieCellPadMinus) / InterfaceConst.divideInto5,
                height: view.frame.height * InterfaceConst.heightMoviePadCell
            )
        }
        return defaultSize
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        InterfaceConst.paddingDefault
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        InterfaceConst.paddingDefault
    }
}

// MARK: - UISearchBarDelegate
extension SearchingView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter?.searchMovies(text)
    }
}

extension SearchingView: SearchingViewProtocol {
    func removeMessageSearchesNotFound() {
        removeMessageLabel()
    }
    
    func showMessageNoSearchesFound(with message: String) {
        displayMessageLabel(with: message)
    }
    
    func showErrorMessage(withMessage: String) {
        viewDisplayError(with: withMessage)
    }
    
    func showMoviesResults(_ moviesFound: [MovieViewModel]) {
        DispatchQueue.main.async {
            self.viewModel = moviesFound
            self.collectionView.reloadData()
        }
    }
    
    func showSpinnerView() {
        self.displaySpinner()
    }
    
    func stopSpinnerView() {
        self.removeSpinner()
    }
    
}

//
//  CastView.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 30/11/21.
//

import Foundation
import UIKit

final class CastView: UICollectionViewController, DisplayError, DisplayMessage, DisplaySpinner {

    // MARK: Properties
    var presenter: CastPresenterProtocol?
    private var viewModel: [CastViewModel] = []

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
        presenter?.viewDidLoad()
        configureUI()
    }

}

// MARK: Helpers
private extension CastView {
    func configureUI() {
        configureCollectionView()
        navigationItem.title = InterfaceConst.cast
    }
    
    func configureCollectionView() {
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: CastCell.reusableIdentifier)
        collectionView.keyboardDismissMode = .interactive
    }
    
}

// MARK: - UITCollectionViewControllerDataSource
extension CastView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCell.reusableIdentifier, for: indexPath) as? CastCell else {
            return CastCell()
        }
        let viewModel = viewModel[indexPath.row]
        cell.viewModel = viewModel
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CastView: UICollectionViewDelegateFlowLayout {

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
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        InterfaceConst.paddingDefault
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        InterfaceConst.paddingDefault
    }
}

extension CastView: CastViewProtocol {
    func showCast(castViewModel: [CastViewModel]) {
        viewModel = castViewModel
        collectionView.reloadData()
    }
    
    func showErrorMessage(withMessage error: String) {
        viewDisplayError(with: error)
    }
    
    func showMessageNoCast(with message: String) {
        displayMessageLabel(with: message)
    }
    
    func showSpinnerView() {
        self.displaySpinner()
    }
    
    func stopSpinnerView() {
        self.removeSpinner()
    }
    
}

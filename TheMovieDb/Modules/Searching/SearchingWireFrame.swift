//
//  SearchingWireFrame.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation
import UIKit

class SearchingWireFrame: SearchingWireFrameProtocol {
    
    class func createSearchingModule() -> UIViewController {
        let view = SearchingView()
        let presenter: SearchingPresenterProtocol & SearchingInteractorOutputProtocol = SearchingPresenter()
        let interactor: SearchingInteractorInputProtocol & SearchingRemoteDataManagerOutputProtocol = SearchingInteractor()
        let localDataManager: SearchingLocalDataManagerInputProtocol = SearchingLocalDataManager()
        let remoteDataManager: SearchingRemoteDataManagerInputProtocol = SearchingRemoteDataManager()
        let wireFrame: SearchingWireFrameProtocol = SearchingWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        return view
        
    }
    
    func showMovieDetail(from view: SearchingViewProtocol, with movie: Movie) {
        let controller = DetailViewController(with: movie)
        guard let view = view as? SearchingView else { return }
        view.navigationController?.pushViewController(controller, animated: true)
    }
}

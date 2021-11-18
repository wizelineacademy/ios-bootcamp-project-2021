//
//  MainTabPresenter.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 14/11/21.
//  
//

import Foundation

final class MainTabPresenter {
    // MARK: Properties
    weak var view: MainTabViewProtocol?
    var wireFrame: MainTabWireFrameProtocol?
    
}

extension MainTabPresenter: MainTabPresenterProtocol {
    func viewWillAppear() {
        guard let view = view else { return }
        wireFrame?.buildControllers(build: view)

    }
}

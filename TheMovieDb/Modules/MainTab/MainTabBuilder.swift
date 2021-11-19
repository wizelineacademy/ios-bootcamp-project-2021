//
//  MainTabBuilder.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 18/11/21.
//

import UIKit.UIViewController

enum MainTabBuilder {
    static func createModule() -> UIViewController {
        let presenter: MainTabPresenterProtocol = MainTabPresenter()
        let view = MainTabView()
        let router: MainTabRouterProtocol = MainTabRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        return view
    }
}

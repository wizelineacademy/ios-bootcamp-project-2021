//
//  DetailSceneRouter.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 21/11/21.
//

import Foundation
import UIKit

protocol DetailSceneRoutingLogic {
    
    func showToast(message: String)
}

final class DetailSceneRouter {
    
    weak var source: UIViewController?
}

extension DetailSceneRouter: DetailSceneRoutingLogic {
    
    func showToast(message: String) {
        Toast.showToast(title: message)
    }
}

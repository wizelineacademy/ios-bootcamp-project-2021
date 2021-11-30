//
//  MockNavigationController.swift
//  TheMovieDbTests
//
//  Created by Karla Rubiano on 28/11/21.
//

import Foundation
import UIKit

final class MockNavigationController: UINavigationController {
    var pushViewControllerCalled = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushViewControllerCalled = true
    }
}

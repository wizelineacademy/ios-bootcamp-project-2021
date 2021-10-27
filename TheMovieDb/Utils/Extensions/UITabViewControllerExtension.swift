//
//  UITabViewControllerExtension.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/10/21.
//

import UIKit.UITabBarController

extension UITabBarController {
    public func templateNavigationController(unseledtedImage: UIImage, selectedImage: UIImage, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseledtedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.title = title
        return nav
    }
}

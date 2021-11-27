//
//  DisplayError.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/11/21.
//

import UIKit

protocol DisplayError {
    func showDisplayError(with message: String)
}

extension DisplayError where Self: UIViewController {
    func showDisplayError(with message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

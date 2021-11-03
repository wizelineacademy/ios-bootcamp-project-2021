//
//  UIViewController+Extensions.swift
//  TheMovieDb
//
//  Created by Luis Alejandro Ramirez Suarez on 3/11/21.
//

import UIKit

extension UIViewController {
    func showErrorAlert(_ error: MovieError) {
        let errorAlert = UIAlertController(title: error.titleError, message: error.messageError, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: Constants.alertButton, style: .default))
        DispatchQueue.main.async {
            self.present(errorAlert, animated: true)
        }
    }
}

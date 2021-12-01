//
//  DisplayError.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 26/11/21.
//

import UIKit.UIViewController

protocol DisplayError {
    func viewDisplayError(with message: String)
}

extension DisplayError where Self: UIViewController {
    func viewDisplayError(with message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: InterfaceConst.okButton, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

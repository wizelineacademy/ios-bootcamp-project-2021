//
//  AlertsBuilderCreator.swift
//  TheMovieDb
//
//  Created by developer on 25/11/21.
//

import Foundation
import UIKit

struct AlertsBuilderCreator {
    static func createAlertWith(message: String) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .destructive)
        alert.addAction(okAction)
        return alert
    }
}

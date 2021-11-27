//
//  UIViewControllerExtension.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 08/11/21.
//

import UIKit.UIViewController
var vSpinner: UIView?

extension UIViewController {
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .systemBackground
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        ai.color = UIColor(named: "BlueAppColor")
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5) {
                vSpinner?.alpha = 0.0
            } completion: { _ in
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
        }
    }
}

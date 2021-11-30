//
//  DisplaySpinner.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 29/11/21.
//

import UIKit.UIViewController

protocol DisplaySpinner {
    func displaySpinner()
    func removeSpinner()
}

extension DisplaySpinner where Self: UIViewController {
    func displaySpinner() {
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = .systemBackground
        spinnerView.tag = InterfaceConst.defaultViewTag
        
        let spinnerIndicator = UIActivityIndicatorView.init(style: .large)
        spinnerIndicator.startAnimating()
        spinnerIndicator.center = spinnerView.center
        spinnerIndicator.color = UIColor(named: InterfaceConst.blueAppColor)
     
        DispatchQueue.main.async {
            spinnerView.addSubview(spinnerIndicator)
            self.view.addSubview(spinnerView)
        }
        
    }
    
    func removeSpinner() {
        let spinnerView = view.viewWithTag(InterfaceConst.defaultViewTag)
        DispatchQueue.main.async {
            UIView.animate(withDuration: InterfaceConst.defaultTimeAnimation) {
                spinnerView?.alpha = InterfaceConst.zeroAlphaValue
            } completion: { _ in
                spinnerView?.removeFromSuperview()
            }
        }
    }
}

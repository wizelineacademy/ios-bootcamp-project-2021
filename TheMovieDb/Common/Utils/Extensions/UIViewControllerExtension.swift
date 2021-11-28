//
//  UIViewControllerExtension.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 08/11/21.
//

import UIKit.UIViewController
var vSpinner: UIView?
var vMessageLabel: UILabel?

extension UIViewController {
    func showMessageOnViewLabel(onView: UIView, message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.font = UIFont.boldSystemFont(ofSize: 16)
            return label
        }()
        
        onView.addSubview(messageLabel)
        messageLabel.centerX(inView: onView)
        messageLabel.centerY(inView: onView)
        
        vMessageLabel = messageLabel
    }
    
    func removeMessageOnViewLabel() {
        vMessageLabel?.removeFromSuperview()
    }
    
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

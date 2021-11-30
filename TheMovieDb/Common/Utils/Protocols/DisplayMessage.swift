//
//  DisplayMessage.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 29/11/21.
//

import UIKit.UIViewController

protocol DisplayMessage {
    func displayMessageLabel(with message: String)
    func removeMessageLabel()
}
extension DisplayMessage where Self: UIViewController {
    func displayMessageLabel(with message: String) {
        let messageLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.tag = InterfaceConst.defaultViewTag
            label.font = UIFont.boldSystemFont(ofSize: InterfaceConst.defaultFontSize)
            return label
        }()
        
        view.addSubview(messageLabel)
        messageLabel.centerX(inView: view)
        messageLabel.centerY(inView: view)
    }
    
    func removeMessageLabel() {
        let messageLabel = view.viewWithTag(InterfaceConst.defaultViewTag)
        messageLabel?.removeFromSuperview()
    }
}

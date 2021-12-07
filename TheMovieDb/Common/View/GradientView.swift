//
//  GradientView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 04/11/21.
//

import Foundation
import UIKit

final class GradientView: UIView {
    
    var initialColor: UIColor = UIColor.clear
    var finalColor: UIColor = UIColor.clear
    
    private var gradient: CAGradientLayer?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupGradient()
        gradient?.frame = rect
    }
    
    func setupGradient() {
        gradient = CAGradientLayer()
        gradient?.type = .axial
        gradient?.colors = [
            initialColor.cgColor,
            finalColor.cgColor,
        ]
        gradient?.locations = [0, 1.0]
        guard let gradient = gradient else {
            return
        }
        layer.addSublayer(gradient)
    }
}

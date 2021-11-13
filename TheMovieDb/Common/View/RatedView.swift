//
//  RatedView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import UIKit

final class RatedView: UIView {
    
    private lazy var valueLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = fontType
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundShape: CAShapeLayer = CAShapeLayer()
    private let ratingShape: CAShapeLayer = CAShapeLayer()
    private let beginValueDegree: Int = -90
    private let endValueDegree: Int = 270
    private let completeCircleDegree: Int = 360
    private var placeholderText: String = ""
    private var maxValue: Float = 0.0
    
    var strokeWidth: CGFloat = 1
    var strokeColor: UIColor? = UIColor.black
    var backStrokeColor: UIColor? = UIColor.black.withAlphaComponent(0.5)
    var fontType: UIFont = UIFont.preferredFont(forTextStyle: .headline,
                                                compatibleWith: nil) {
        didSet {
            valueLabel.font = fontType
        }
    }
    
    var value: Float = 0.0 {
        didSet {
            valueLabel.text = value == 0 ? placeholderText : String(value)
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    init(frame: CGRect,
         maxValue: Float = 100,
         placeholderText: String = "--") {
        super.init(frame: frame)
        setup(placeholder: placeholderText, maxValue: maxValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) failed")
    }
    
    func setup(placeholder: String, maxValue: Float) {
        self.placeholderText = placeholder
        self.maxValue = maxValue
        addSubview(valueLabel)
        valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackgroundShape(rect)
        drawTimeLeftShape(rect)
    }
    
    func drawBackgroundShape(_ rect: CGRect) {
        backgroundShape.path = UIBezierPath(arcCenter: CGPoint(x: rect.midX,
                                                               y: rect.midY),
                                            radius: rect.width / 2,
                                            startAngle: beginValueDegree.degreesToRadians,
                                            endAngle: endValueDegree.degreesToRadians,
                                            clockwise: true).cgPath
        backgroundShape.strokeColor = backStrokeColor?.cgColor
        backgroundShape.fillColor = UIColor.clear.cgColor
        backgroundShape.lineWidth = strokeWidth
        DispatchQueue.main.async {
            self.layer.addSublayer(self.backgroundShape)
        }
    }
    
    func drawTimeLeftShape(_ rect: CGRect) {
        let advanceDegree: Int = Int(Float(completeCircleDegree) * (value / maxValue)) + beginValueDegree
        ratingShape.path = UIBezierPath(arcCenter: CGPoint(x: rect.midX,
                                                           y: rect.midY),
                                        radius: rect.width / 2,
                                        startAngle: beginValueDegree.degreesToRadians,
                                        endAngle: advanceDegree.degreesToRadians,
                                        clockwise: true).cgPath
        ratingShape.strokeColor = strokeColor?.cgColor
        ratingShape.fillColor = UIColor.clear.cgColor
        ratingShape.lineWidth = strokeWidth
        DispatchQueue.main.async {
            self.layer.addSublayer(self.ratingShape)
        }
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

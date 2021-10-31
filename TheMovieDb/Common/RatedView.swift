//
//  RatedView.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 31/10/21.
//

import UIKit

final class RatedView: UIView {
    
    private lazy var progressLabel: UILabel = {
        let label: UILabel = UILabel(frame: .zero)
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: nil)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backgroundShape: CAShapeLayer = CAShapeLayer()
    private let ratingShape: CAShapeLayer = CAShapeLayer()
    private let beginValueDegree: Int = -90
    private let endValueDegree: Int = 270
    private let completeCircleDegree: Int = 360
    
    var progress: Int = 53 {
        didSet {
            progressLabel.text = String(progress)
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        addSubview(progressLabel)
        progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackgroundShape()
        drawTimeLeftShape()
    }
    
    func drawBackgroundShape() {
        backgroundShape.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX,
                                                               y: bounds.midY),
                                            radius: frame.width / 2,
                                            startAngle: beginValueDegree.degreesToRadians,
                                            endAngle: endValueDegree.degreesToRadians,
                                            clockwise: true).cgPath
        backgroundShape.strokeColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        backgroundShape.fillColor = UIColor.clear.cgColor
        backgroundShape.lineWidth = 5
        layer.addSublayer(backgroundShape)
    }
    
    func drawTimeLeftShape() {
        let advanceDegree: Int = Int(Float(completeCircleDegree) * (Float(progress) / 100)) + beginValueDegree
        ratingShape.path = UIBezierPath(arcCenter: CGPoint(x: bounds.midX,
                                                           y: bounds.midY),
                                        radius: frame.width / 2,
                                        startAngle: beginValueDegree.degreesToRadians,
                                        endAngle: advanceDegree.degreesToRadians,
                                        clockwise: true).cgPath
        ratingShape.strokeColor = UIColor.red.cgColor
        ratingShape.fillColor = UIColor.clear.cgColor
        ratingShape.lineWidth = 5
        layer.addSublayer(ratingShape)
    }
}

extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}

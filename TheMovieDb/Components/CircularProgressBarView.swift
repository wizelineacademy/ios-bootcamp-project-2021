//
//  CircularProgressBarView.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 30/10/21.
//

import UIKit

protocol CircularProgressBarViewProtocol {
  func progressAnimation(duration: TimeInterval)
  func createCircularPath()
}

final class CircularProgressBarView: UIView, CircularProgressBarViewProtocol {
  
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  private var startPoint = CGFloat(-Double.pi / 2)
  private var endPoint = CGFloat(3 * Double.pi / 2)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  func createCircularPath() {
    // created circularPath for circleLayer and progressLayer
    let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: startPoint, endAngle: endPoint, clockwise: true)
    // circleLayer path defined to circularPath
    circleLayer.path = circularPath.cgPath
    // ui edits
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineCap = .round
    circleLayer.lineWidth = 20.0
    circleLayer.strokeEnd = 1.0
    circleLayer.strokeColor = UIColor.white.cgColor
    // added circleLayer to layer
    layer.addSublayer(circleLayer)
    // progressLayer path defined to circularPath
    progressLayer.path = circularPath.cgPath
    // ui edits
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.lineWidth = 10.0
    progressLayer.strokeEnd = 0
    progressLayer.strokeColor = UIColor.green.cgColor
    // added progressLayer to layer
    layer.addSublayer(progressLayer)
  }
  
  func progressAnimation(duration: TimeInterval) {
    // created circularProgressAnimation with keyPath
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    // set the end time
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = 1.0
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
  }
  
}

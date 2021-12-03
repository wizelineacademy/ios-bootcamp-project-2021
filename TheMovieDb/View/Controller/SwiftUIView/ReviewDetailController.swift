//
//  ReviewDetailController.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/23/21.
//

import UIKit
import SwiftUI

class ReviewDetailController: UIViewController {
  
  var review: ReviewViewModel?
  
  init(review: ReviewViewModel) {
    self.review = review
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let controller = UIHostingController(rootView: ReviewView())
    self.addChild(controller)
    self.view.addSubview(controller.view)
    controller.didMove(toParent: self)
    controller.rootView.review = review
    controller.view.fillSuperview()
  }
  
}

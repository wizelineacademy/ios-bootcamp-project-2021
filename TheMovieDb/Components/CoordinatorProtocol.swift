//
//  CoordinatorProtocl.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 04/11/21.
//

import Foundation
import UIKit
protocol Coordinator {
  var children: [Coordinator] {get set}
  var navigationController: UINavigationController {get set}
  
  func start()
}

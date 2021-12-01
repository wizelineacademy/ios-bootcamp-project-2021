//
//  Extensions.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/18/21.
//

import UIKit

extension UIView {

  func showLoading(view: inout UIActivityIndicatorView) {
    addSubview(view)
    view.centerYInSuperview()
    view.centerXInSuperview()
    view.startAnimating()
  }
  
  func stopLoading(view: inout UIActivityIndicatorView) {
    view.stopAnimating()
    view.removeFromSuperview()
  }
  
}

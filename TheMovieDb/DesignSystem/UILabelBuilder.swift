//
//  UILabelBuilder.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import Foundation
import UIKit

class UILabelBuilder {
  
  var label = UILabel()
  
  func fontStyle(textStyle: TextStyle, weight: UIFont.Weight) -> UILabelBuilder {
    self.label.font = .systemFont(ofSize: textStyle.size, weight: weight)
    return self
  }
  
  func amountLines(numLines: Int) -> UILabelBuilder {
    self.label.numberOfLines = numLines
    return self
  }
  
  func setColor(color: DesignColor) -> UILabelBuilder {
    self.label.textColor = color.color
    return self
  }
  
  func setText(text: String) -> UILabelBuilder {
    self.label.text = text
    return self
  }
  
  func build() -> UILabel {
    return label
  }
  
}

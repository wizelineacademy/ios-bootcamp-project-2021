//
//  UILabelBuilder.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/2/21.
//

import UIKit

// MARK: Builder for UILabel element

class LabelBuilder {
  
  var label = UILabel()
  
  func fontStyle(textStyle: TextStyle, weight: UIFont.Weight) -> LabelBuilder {
    self.label.font = .systemFont(ofSize: textStyle.size, weight: weight)
    return self
  }
  
  func amountLines(numLines: Int) -> LabelBuilder {
    self.label.numberOfLines = numLines
    return self
  }
  
  func setColor(color: DesignColor) -> LabelBuilder {
    self.label.textColor = color.color
    return self
  }
  
  func setText(text: String) -> LabelBuilder {
    self.label.text = text
    return self
  }
  
  func setInteraction(isInteraction: Bool) -> LabelBuilder {
    self.label.isUserInteractionEnabled = true
    return self
  }
  
  func lineBreakMode(mode: NSLineBreakMode) -> LabelBuilder {
    self.label.lineBreakMode = mode
    return self
  }
  
  func build() -> UILabel {
    return label
  }
  
}

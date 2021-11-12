//
//  Header.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class HeaderFeedView: UICollectionReusableView {
  
  static let identifier = "TitleHeaderView"
  
  var label = LabelBuilder()
    .fontStyle(textStyle: .subtitle, weight: .bold)
    .setColor(color: .white)
    .setText(text: "Categories")
    .build()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }
  
  func setup() {
    addSubview(label)
    label.frame = bounds
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

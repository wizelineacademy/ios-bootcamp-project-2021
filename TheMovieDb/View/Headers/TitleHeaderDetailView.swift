//
//  TitleHeaderView.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class TitleHeaderDetailView: UICollectionReusableView {
  
  static let identifier = "TitleHeaderView"
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var titleLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .bold)
    .setColor(color: .purple)
    .build()
  
  func setupView() {

    addSubview(titleLabel)
    
    titleLabel.centerYInSuperview()
    titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))

  }
        
}

//
//  BaseCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

protocol ComplementBaseCell {
  func setupView()
  func setupData()
}

class BaseCell: UICollectionViewCell, ComplementBaseCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {}
  
  func setupData() {}

}

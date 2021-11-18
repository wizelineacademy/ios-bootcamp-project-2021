//
//  CastCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class CastCell: BaseCell {
  
  static let identifier = "CastCell"
  
  var person: Person? {
    didSet {
      setupData()
    }
  }
  
  var profileImage = ImageBuilder()
    .aspectImage(aspectRatio: .scaleAspectFill)
    .roundCorners(circle: true, radius: SizeAndMeasures.profilePictureBig.measure, clipped: true)
    .setBackgroundColor(color: .darkGray)
    .setPlaceHolder(image: UIImage(named: "notFoundImage"))
    .build()
  
  var nameLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .bold)
    .setColor(color: .gray)
    .build()
  
  var characterLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .regular)
    .setColor(color: .darkGray)
    .build()
  
  override func setupView() {
    
    backgroundColor = DesignColor.transparentWhite.color
    layer.cornerRadius = SizeAndMeasures.cornerRadiusBig.measure

    let widthAndHeightProfileImage = SizeAndMeasures.profilePictureBig.measure
    profileImage.constrainWidth(constant: widthAndHeightProfileImage)
    profileImage.constrainHeight(constant: widthAndHeightProfileImage)

    let infoStack = VerticalStackView(arrangedSubviews: [nameLabel, characterLabel], spacing: 0)
    
    let allInfoStack = HorizontalStackView(arrangedSubviews: [profileImage, infoStack], spacing: 10)
    addSubview(allInfoStack)
    allInfoStack.alignment = .center
    allInfoStack.centerYInSuperview()
    allInfoStack.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))

  }
  
  override func setupData() {
    guard let name = person?.name, let character = person?.character else { return }
    let url: String?
    if let portrait = person?.profilePath {
      url = "\(ApiPath.baseUrlImage.path)\(portrait)"
    } else { url = nil }
    profileImage.loadImage(urlString: url)
    self.nameLabel.text = name
    self.characterLabel.text = character
  }

}

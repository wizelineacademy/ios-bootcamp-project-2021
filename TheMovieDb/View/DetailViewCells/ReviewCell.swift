//
//  ReviewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit
import Foundation
import Kingfisher

class ReviewCell: BaseCell {
  
  static let identifier = "ReviewCell"
  
  var review: MovieReview? {
    didSet {
      setupData()
    }
  }
  
  var profileImage = ImageBuilder()
    .sizeAndAspectImage(width: 30, height: 30, aspectRatio: .scaleAspectFill)
    .roundCorners(circle: true, radius: 0, clipped: true)
    .setBackgroundColor(color: .lightGray)
    .build()
  
  var nameLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .bold)
    .setColor(color: .whiteDirt)
    .build()
  
  var writeForLabel = LabelBuilder()
    .fontStyle(textStyle: .subheadline, weight: .regular)
    .setColor(color: .gray)
    .setText(text: "Written by")
    .build()
  
  let descriptionLabel = LabelBuilder()
    .fontStyle(textStyle: .paragraph, weight: .regular)
    .amountLines(numLines: 0)
    .setColor(color: .whiteDirt)
    .lineBreakMode(mode: .byWordWrapping)
    .build()
  
  override func setupView() {
    clipsToBounds = true
    profileImage.constrainWidth(constant: 30)
    profileImage.constrainHeight(constant: 30)
    
    let nameStack = HorizontalStackView(arrangedSubviews: [writeForLabel, nameLabel], spacing: 5)
    nameStack.alignment = .center

    let infoStack = HorizontalStackView(arrangedSubviews: [profileImage, nameStack, UIView()], spacing: 10)
    infoStack.alignment = .center
    
    let allViews = VerticalStackView(arrangedSubviews: [infoStack, descriptionLabel], spacing: 20)
    allViews.alignment = .leading
    addSubview(allViews)
    allViews.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  override func setupData() {

    guard let name = review?.author, let description = review?.content else { return }
    if let portrait = review?.authorDetails.avatarPath {
      let imageProvider = ImageResource(downloadURL: URL(string: "\(ApiPath.baseUrlImage.path)\(portrait)")!)
      self.profileImage.kf.setImage(with: imageProvider)
    }
    
    self.nameLabel.text = name
    self.descriptionLabel.text = description

  }
  
}

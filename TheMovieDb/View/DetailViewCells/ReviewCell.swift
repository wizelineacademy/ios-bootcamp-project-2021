//
//  ReviewCell.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

class ReviewCell: BaseCell {
  
  static let identifier = "ReviewCell"
  
  var review: MovieReview? {
    didSet {
      setupData()
    }
  }
  
  var profileImage = ImageBuilder()
    .aspectImage(aspectRatio: .scaleAspectFill)
    .roundCorners(circle: true, radius: SizeAndMeasures.profilePictureSmall.measure, clipped: true)
    .setPlaceHolder(image: UIImage(systemName: "person.crop.circle"))
    .setBackgroundColor(color: .transparentWhite)
    .setTinColor(color: DesignColor.darkGray)
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
    let widthAndHeightProfileImage = SizeAndMeasures.profilePictureSmall.measure
    profileImage.constrainWidth(constant: widthAndHeightProfileImage)
    profileImage.constrainHeight(constant: widthAndHeightProfileImage)
    
    let nameStack = HorizontalStackView(arrangedSubviews: [writeForLabel, nameLabel], spacing: 5)
    nameStack.alignment = .center
    
    let infoStack = HorizontalStackView(arrangedSubviews: [profileImage, nameStack, UIView()], spacing: 10)
    infoStack.alignment = .center
    
    let allViews = VerticalStackView(arrangedSubviews: [infoStack, descriptionLabel], spacing: 20)
    allViews.alignment = .leading
    addSubview(allViews)
    allViews.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
  }
  
  override func setupData() {
    
    guard let name = review?.author, let description = review?.content else { return }
    var url: String?
    var portrait = review?.authorDetails.avatarPath
    let checkValidUrl = portrait?.prefix(9)
    if checkValidUrl == "/https://" {
      portrait?.removeFirst()
      url = portrait
    } else {
      if portrait != nil {
        url = "\(ApiPath.baseUrlImage.path)\(portrait ?? "")"
      }
    }

    self.profileImage.loadImage(urlString: url)
    self.nameLabel.text = name
    self.descriptionLabel.text = description
    
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    profileImage.image = nil
  }
  
}

//
//  ImageBuilder.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/11/21.
//

import UIKit

// MARK: Builder for UIImageView element

class ImageBuilder {
  
  var image = CacheImageView()
  
  func sizeAndAspectImage(width: CGFloat, height: CGFloat, aspectRatio: UIView.ContentMode ) -> ImageBuilder {
    self.image.frame = .init(x: 0, y: 0, width: width, height: height)
    self.image.contentMode = aspectRatio
    return self
  }
  
  func roundCorners(circle: Bool, radius: CGFloat?, clipped: Bool) -> ImageBuilder {
    self.image.layer.cornerRadius = circle ? self.image.frame.height / 2 : radius ?? 0
    self.image.clipsToBounds = clipped
    return self
  }
  
  func imageOpacity(opacity: Float) -> ImageBuilder {
    self.image.layer.opacity = opacity
    return self
  }
  
  func activeInteraction() -> ImageBuilder {
    self.image.isUserInteractionEnabled = true
    return self
  }
  
  func setBackgroundColor(color: DesignColor) -> ImageBuilder {
    self.image.backgroundColor = color.color
    return self
  }

  func systemImage(iconName: String, color: DesignColor?, size: CGFloat?) -> ImageBuilder {
    if size != nil {
      let sizeFont = UIFont.systemFont(ofSize: size ?? 0)
      let iconSize = UIImage.SymbolConfiguration(font: sizeFont)
      self.image.image = UIImage(systemName: iconName, withConfiguration: iconSize)
    } else {
      self.image.image = UIImage(systemName: iconName)
    }
    if color != nil {
      self.image.tintColor = color?.color
    }
    return self
  }
  
  func setPlaceHolder(image: UIImage?) -> ImageBuilder {
    guard let placeholder = image else { return self }
    self.image.emptyImage = placeholder
    return self
  }
  
  func build() -> CacheImageView {
    return image
  }
  
}

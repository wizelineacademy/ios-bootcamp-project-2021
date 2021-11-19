//
//  SizeAndMeasures.swift
//  TheMovieDb
//
//  Created by Michael do Prado on 11/17/21.
//

import UIKit

enum SizeAndMeasures {
  case zero
  case margin
  case topHeadersHeight
  case normalHeadersHeight
  case movieCellSizeWidth
  case movieCellSizeHeight
  case profilePictureBig
  case profilePictureSmall
  case cornerRadiusBig
  case cornerRadiusSmall
  case cellWithTextHeight(String, TextStyle, CGFloat)
  case sizeScreen
  
  var measure: CGFloat {
    switch self {
    case .zero: return 0
    case .margin: return 20
    case .topHeadersHeight: return UIScreen.main.bounds.width / 1.3
    case .normalHeadersHeight: return 80
    case .movieCellSizeWidth: return 0.45
    case .movieCellSizeHeight: return UIScreen.main.bounds.width / 1.6
    case .profilePictureBig: return 60
    case .profilePictureSmall: return 30
    case .cornerRadiusBig: return 20
    case .cornerRadiusSmall: return 10
    case .cellWithTextHeight(let text, let fontSize, let widthLabel):
      return estimatedHeightForText(text, fontSize: fontSize, widthLabel: widthLabel)
    case .sizeScreen: return UIScreen.main.bounds.width
    }
  }
  
  func estimatedHeightForText(_ text: String, fontSize: TextStyle, widthLabel: CGFloat) -> CGFloat {
    
    let approximateWidthOfBioTextView = widthLabel
    let size = CGSize(width: approximateWidthOfBioTextView, height: 1000)
    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize.size)]
    let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
    
    return estimatedFrame.height
  }
}

//
//  String+Extension.swift
//  TheMovieDb
//
//  Created by Juan Alfredo García González on 07/11/21.
//

import Foundation
import UIKit

extension String {
    func height(basedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
}

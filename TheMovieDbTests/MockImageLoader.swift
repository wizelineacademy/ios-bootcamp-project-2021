//
//  MockImageLoader.swift
//  TheMovieDbTests
//
//  Created by Ricardo Ramirez on 30/11/21.
//

import Foundation
@testable import TheMovieDb
import UIKit

class MockImageLoader: ImageProvider {
    
    var image: UIImage?
    
    func getImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        completion(image)
    }
    
}

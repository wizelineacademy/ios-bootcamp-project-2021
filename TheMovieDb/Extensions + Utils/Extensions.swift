//
//  Extensions.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation
import UIKit

extension URLSession {
func dataTask(with url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
    guard let url = URL(string: url) else { return nil }
    return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }
}


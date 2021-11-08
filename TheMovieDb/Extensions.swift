//
//  Extensions.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 07/11/21.
//

import Foundation
import UIKit

extension URLSession {
    static var mock: MockURLSession {
        MockURLSession()
    }
    func dataTask(with url: String, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }
        return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }
}

public class MockURLSession: URLSession {
    public override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.5...2)) {
                completionHandler(data, response, error)
            }
        }
    }
}

extension UIImageView {

func posterFetcher(url: URL, contentMode mode:  UIView.ContentMode = .scaleAspectFit) {

    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
            else {
                return
                }
            DispatchQueue.main.async() {
                self.image = image
                
            }
        }.resume()
    }

}

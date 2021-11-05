//
//  ViewController.swift
//  TheMovieDb
//
//  Created by Jose Antonio Trejo Flores on 09/12/20.
//

import UIKit

class ViewController: UIViewController {

    let service = NetworkManager(urlSession: URLSession.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "/3/trending/movie/day"
        service.get(path: url) { response in
            print(response as MovieList)
        }
    }
}


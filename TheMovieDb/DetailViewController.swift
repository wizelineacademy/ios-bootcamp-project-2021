//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Sandra Herrera on 02/12/21.
//

import UIKit

final class DetailViewController: UIViewController {
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


        init() {
            super.init(nibName: nil, bundle: nil)
            //Do whatever you want here
        }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Movie Detail"
    }
}

//
//  LoadingViewController.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 02/11/21.
//

import UIKit

final class LoadingViewController: UIViewController {
    
    lazy var spinner = UIActivityIndicatorView()
    
    override func loadView() {
        super.loadView()
        setupUI()
        activateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        spinner.stopAnimating()
    }
    
    func setupUI() {
        view.addSubview(spinner)
    }
    
    func activateConstraints() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

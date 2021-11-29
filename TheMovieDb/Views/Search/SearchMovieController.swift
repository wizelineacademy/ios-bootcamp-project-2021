//
//  SearchMovieController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 29/11/21.
//

import UIKit

class SearchMovieController: UIViewController {
    
    private var tableView: GenericTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpTableView()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView() {
        tableView = GenericTableViewController(frame: view.bounds)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.isHidden = true
    }

}

//
//  HomeTableViewController.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 12/11/21.
//

import UIKit
import Kingfisher

class GenericTableViewController: UITableView {
    var arrMovies: [Movie] = [] {
        didSet {
            delegate = self
            dataSource = self
            setUpCell()
            self.reloadData()
        }
    }
    
    private func setUpCell() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension GenericTableViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
   
       
        content.text = arrMovies[indexPath.row].title

        // Customize appearance.
        content.imageProperties.tintColor = .purple

        cell.contentConfiguration = content
        return cell
    }
}

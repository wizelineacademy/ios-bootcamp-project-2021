//
//  TableViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 26/10/21.
//

import UIKit

class TableViewController: UITableViewController {
    
    var moviesCategory: [(name: String, type: MovieListEndpoint)] = [("Trending", .trending),
                                        ("Now Playing", .nowPlaying),
                                        ("Popular", .popular),
                                        ("Top Rated", .topRated),
                                        ("Upcoming", .upcoming)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Show Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = moviesCategory[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? ViewController {
            let category = moviesCategory[indexPath.row]
            vc.type = category.type
            vc.typeTitle = category.name
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

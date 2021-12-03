//
//  HomeViewController.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 10/11/21.
//

import UIKit
import Kingfisher

class HomeViewController: UITableViewController {

    private var selectedMovie: Movie?
    let facade = MovieFacade()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.rowHeight = 100
        
        facade.getAllMovies {
            self.tableView.reloadData()
        }
    }
}
    
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return facade.sectionData[section].category.rawValue
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        facade.sectionData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        facade.sectionData[section].movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let movie = facade.sectionData[indexPath.section].movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        
        if let posterPath = movie.posterPath {
            let baseImageUrl = "https://image.tmdb.org/t/p/w500"
            let imageUrl = URL(string: baseImageUrl + posterPath)
            cell.imageView?.kf.setImage(with: imageUrl) { _ in
                cell.setNeedsLayout()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = facade.sectionData[indexPath.section].movies[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        selectedMovie = movie
        performSegue(withIdentifier: "ToDetailsScreen", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailsScreen" {
            let viewController = segue.destination as? DetailsViewController
            viewController?.movie = selectedMovie!
        }
    }
    
}

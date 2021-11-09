//
//  PresenterViewTable.swift
//  TheMovieDb
//
//  Created by Jonathan Hernandez on 08/11/21.
//

import UIKit

protocol HomeTableViewPresenter {
    init(view: HomeView)
    func fetchMovieList()
}
 
class HomeTableViewPresenterImp: HomeTableViewPresenter {

    weak var viewHome: HomeView?
    private let clientMoive: MovieDBClient? = MovieDBClient()
    
    required init(view: HomeView) {
        self.viewHome = view
   }
    
    func fetchMovieList() {
   
        viewHome?.showLoading()
        clientMoive?.getNowPlayingMovies(page: 1) {[weak self] result in
            switch result {
            case .success(let respMovie):
                guard let movieResult = respMovie,
                      let movieList = movieResult.results
                else {
                    self?.viewHome?.showEmptyState()
                    return
                }
    
                self?.viewHome?.shoowMovies(arrMovie: movieList )
               
            case .failure(let error):
                print(error)
            }
            self?.viewHome?.stopLoading()
        }
    }
    
    
}

protocol HomeView: AnyObject {
    func showLoading()
    func stopLoading()
    func shoowMovies(arrMovie: [Movie])
    func showEmptyState()
}

class PresenterViewTable: UIViewController, HomeView {
    func showEmptyState() {
       print("")
    }

    var presenter: HomeTableViewPresenterImp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchMovieList()
    }
    
    
    func showLoading() {
        print("")
    }
    
    func stopLoading() {
        print("")
    }
    
    func shoowMovies(arrMovie: [Movie]) {
        print(arrMovie)
    }
    

    // MARK: - Table view data source

 

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

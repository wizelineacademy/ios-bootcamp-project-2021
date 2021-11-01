//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

final class MainViewController: UIViewController {
  
  private var trendingMovies: [Movie] = []
  private var nowPlayingMovies: [Movie] = []
  private var popularMovies: [Movie] = []
  private var topRatedMovies: [Movie] = []
  private var upcomingMovies: [Movie] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    // Do any additional setup after loading the view.
    requestAPI()
    
  }
  
  func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "MovieDB"
    
  }
  
  private func requestAPI() {
    let completion: (Result<MovieList, Error>) -> Void = { [weak self] result in
        debugPrint(result)
        switch result {
        case .success(let response):
          self?.trendingMovies = response.results
          print(response)
        default:
          self?.trendingMovies = []
        }
    }
    API.getTrendingMovies.resume(completion: completion)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

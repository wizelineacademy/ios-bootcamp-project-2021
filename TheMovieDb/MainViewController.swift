//
//  MainViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 26/10/21.
//

import UIKit

class MainViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    // Do any additional setup after loading the view.
    
  }
  
  func configureNavigationController() {
    guard let navigationBar = self.navigationController?.navigationBar else { return }
    navigationBar.tintColor = .black
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    navigationBar.prefersLargeTitles = true
    self.title = "MovieDB"
    
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

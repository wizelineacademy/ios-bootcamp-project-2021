//
//  DetailReviewViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 05/11/21.
//

import UIKit

class DetailReviewViewController: UIViewController {

  private var author: String?
  private var rating: Float?
  private var content: String?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  init(author: String, rating: Float, content: String) {
    self.author = author
    self.content = content
    self.rating = rating
    super.init(nibName: "DetailReviewViewController", bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

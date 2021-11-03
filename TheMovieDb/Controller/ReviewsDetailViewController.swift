//
//  ReviewsDetailViewController.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 1/11/21.
//

import UIKit

final class ReviewsDetailViewController: UIViewController {

    @IBOutlet weak var reviewCompletedText: UITextView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    var review: ReviewsDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        reviewCompletedText.text = review?.content
        authorLabel.text = "Author: \(review?.author ?? "Unavailable")"
    }
}

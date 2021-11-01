//
//  ReviewDescriptionViewController.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 31/10/21.
//

import UIKit

final class ReviewDescriptionViewController: UIViewController {
    private let descriptionReviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = "The Martix is a great example of a movie that will live for ever or a very log time. The story and concept are out of this world. Keanu Reeves plays his role with utter brilliance, the cast was very well put together and the graphics are still to this day amazing. All in all one of the best movies of all time"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(descriptionReviewLabel)
        descriptionReviewLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20)

    }
}

//
//  MovieDetailsViewController.swift
//  TheMovieDb
//
//  Created by Antonio Hernandez Ambrocio on 15/11/21.
//

import UIKit
import SwiftUI

final class DetailsViewController: UIHostingController<DetailsSwiftUIView> {
    var movie: Movie?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: DetailsSwiftUIView(movie: movie))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView = DetailsSwiftUIView(movie: movie)

    }
    /*func getCast(movieId: Int, Completion: @escaping (Cast) -> Void) {
        let getCastRepo = GetCast()
        var credits: [Cast] = []
        getCastRepo.getCredits(option: .cast(movieId: movieId)) { Credits in
            credits.append(contentsOf: Credits.cast)
        }
    }*/
}

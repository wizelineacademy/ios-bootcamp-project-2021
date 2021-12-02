//
//  DetailViewController.swift
//  TheMovieDb
//
//  Created by Rob Cruz on 31/10/21.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    
    // MARK: - Hosting View for SwiftUI
    
    var movieData: Movie?
    let swiftUI = DetailView()
    
    func buildDetail () -> DetailView {
        var swiftUI = DetailView()
        swiftUI.movieData = movieData
        return swiftUI
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = UIHostingController(rootView: buildDetail())
        
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
}

//
//  MovieDetailViewController.swift
//  TheMovieDb
//
//  Created by developer on 05/11/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = MovieDetailDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        collectionView.collectionViewLayout = CompotitionalLayoutCreator.createLayoutForMovieDetail()
        collectionView.setup(dataSource: dataSource)
        collectionView.registerNibForCellWith(name: HeaderCollectionViewCell.identifierToDeque)
        collectionView.registerNibForCellWith(name: MovieCollectionViewCell.identifierToDeque)

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

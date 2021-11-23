//
//  ReviewDetailProtocols.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 11/11/21.
//  
//

import UIKit.UIViewController

protocol ReviewDetailBuilderProtocol {
    static func createModule(with review: Review) -> UIViewController
}

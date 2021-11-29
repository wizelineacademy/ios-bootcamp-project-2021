//
//  PresentViewController.swift
//  TheMovieDb
//
//  Created by Juan David Torres on 04/11/21.
//

import Foundation
import UIKit

protocol ChangeViewDelegate: AnyObject {
  func changeDetailVC(movieViewModel: MovieViewModel?)
}

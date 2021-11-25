//
//  AttibutedTextCreator.swift
//  TheMovieDb
//
//  Created by developer on 20/11/21.
//

import Foundation
import UIKit

struct AttributedTextCreator {
    static func textForMovieDetailInfo(movie: MovieDetailProtocol) -> NSAttributedString {
        
        let firstAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 30)]
        let secondAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 17)]
        let thirdAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 15)]
        
        let fourthrAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 15)]
        
        let firstString = NSMutableAttributedString(string: movie.title + "\n", attributes: firstAttributes)
        
        let secondString = NSMutableAttributedString(string: movie.overview + "\n\n", attributes: secondAttributes)
        
        let thirdString = NSMutableAttributedString(string: "Release: " + (DateFormatterManager.formatToReadableString(dateString: movie.releaseDate) ?? "") + "\n", attributes: thirdAttributes)
        
        let fourthString = NSMutableAttributedString(string: "Popularity: " + movie.popularity.description + "\n\n", attributes: fourthrAttributes)

        let fifthString = NSMutableAttributedString(string: "Similar Movies \n", attributes: thirdAttributes)

        firstString.append(secondString)
        firstString.append(thirdString)
        firstString.append(fourthString)
        firstString.append(fifthString)

        return firstString
    }
}

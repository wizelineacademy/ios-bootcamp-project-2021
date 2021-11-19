//
//  SearchSubtitleTableViewCell.swift
//  TheMovieDb
//
//  Created by Karla Rubiano on 9/11/21.
//

import UIKit

final class SearchSubtitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

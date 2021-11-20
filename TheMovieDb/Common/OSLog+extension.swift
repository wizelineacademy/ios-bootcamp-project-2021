//
//  OSLog+extension.swift
//  TheMovieDb
//
//  Created by Ricardo Ramirez on 19/11/21.
//

import Foundation
import os.log

extension OSLog {
    private static var subSystem = Bundle.main.bundleIdentifier!
    
    static let networkRequest = OSLog(subsystem: subSystem, category: "networking")
    static let viewModel = OSLog(subsystem: subSystem, category: "viewModel")
}

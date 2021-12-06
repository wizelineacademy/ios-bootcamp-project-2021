//
//  Log.swift
//  TheMovieDb
//
//  Created by Javier Cueto on 16/11/21.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let viewCycle = OSLog(subsystem: subsystem, category: "View Cycle")
    static let networkError = OSLog(subsystem: subsystem, category: "Network Layer")
    static let imageService = OSLog(subsystem: subsystem, category: "Image Service")
    static let generalInfo = OSLog(subsystem: subsystem, category: "General info")
}

enum Log {
    case viewDidload
    case networkLayer(Error)
    case imageService(Error)
    case generalInfo(String)
    
    var description: Void {
        switch self {
        case .viewDidload:
             os_log("View did load!", log: OSLog.viewCycle, type: .info)
        case .networkLayer(let error):
            os_log("Error network: %@", log: OSLog.networkError, type: .error, error.localizedDescription)
        case .imageService(let error):
            os_log("Error in download image: %@", log: OSLog.imageService, type: .error, error.localizedDescription)
        case .generalInfo(let message):
            os_log("Info: %@", log: OSLog.imageService, type: .info, message)
        }
    }
 
}

//
//  Logger.swift
//  oHash
//
//  Created by Brendan White on 1/4/2024.
//

import Foundation

import OSLog
extension Logger {
    private static let appIdentifier = Bundle.main.bundleIdentifier ?? ""
    static let misc      = Logger(subsystem: appIdentifier, category: "misc" )

    static let djopen    = Logger(subsystem: appIdentifier, category: "djopen"    )
    static let graticule = Logger(subsystem: appIdentifier, category: "graticule" )
    static let hashpoint = Logger(subsystem: appIdentifier, category: "hashpoint" )
}

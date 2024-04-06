//
//  Date.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation

extension Date: RawRepresentable {
    
    // Converters forRawRepresentable
    public init?(rawValue: String) {
        self = ISO8601DateFormatter().date(from: rawValue) ?? Date.now
    }
    public var rawValue: String {
        return self.ISO8601Format() // note - this is the date AND TIME
    }
    
    // convert to & from ISO8601 date string
    // but just the date, NOT date and time, eg 2005-05-26
    static public func fromISO8601String(_ s:String) -> Date {
        try! Self.iso8601.parse(s)
    }

    public static let iso8601 = Date.ISO8601FormatStyle()
        .year().month().day()

}

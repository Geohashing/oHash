//
//  Date.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation

extension Date {

    static public func dateFromString(_ s:String) -> Date {
        try! Self.iso8601.parse(s)
    }

    public static let iso8601 = Date.ISO8601FormatStyle()
        .year().month().day()

}

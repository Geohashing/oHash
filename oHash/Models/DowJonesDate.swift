//
//  DowJonesDate.swift
//  oHash
//
//  Created by Brendan White on 24/3/2024.
//

import Foundation
import SwiftUI

enum DowJonesError {
    case timeout_error
    case network_error
    case unknown_error
}

enum DowJonesStatus {
    case already_had_it
    case too_early
    case already_checked_recently
    case getting_it_now
    case just_got_it
    case error(_ error:DowJonesError)
}

class DowJonesDate {
    private let date:Date

    private let dowJonesStatus:DowJonesStatus

    private let lastCheckTime = Date.now
    private let lastCheckIntervalSeconds = 10
    
    private var dowJonesOpen:String?
                
    init(date: Date) {
        self.date = date
        
        // First, get the DJ Open from the cache, if we can
        dowJonesOpen = Self.getDowJonesOpenFor(date)
        if (dowJonesOpen != nil) {
            dowJonesStatus = .already_had_it
            return
        }
        
        // Next, if it's before the DJ opening time for that date,
        // return status .too_early
        
        
        // if we get to here, the DJ Open should be available,
        // but we don't have it yet.
        // Is it too soon after the last check?
        // If so, return status .already_checked_recently
        
        
        // If we get here, the DJ Open should be available, and we
        // haven't checked recently. So let's try to get it!!!
        
        
        
        // if we get this far, we had a weird and unknown problem
        dowJonesOpen = nil
        dowJonesStatus = .error(.unknown_error)
        return
    }
    
    static func getDowJonesOpenFor(_ date:Date) -> String? {
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFullDate
        let dateString = dateFormatter.string(from: date)

        let defaults = UserDefaults.standard
        let openString = defaults.object(forKey:dateString) as? String
        
        return openString
    }

}

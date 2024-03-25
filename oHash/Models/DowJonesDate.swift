//
//  DowJonesDate.swift
//  oHash
//
//  Created by Brendan White on 24/3/2024.
//

import Foundation
import SwiftUI

enum DowJonesError {
    case before_djia_existed_error
    case timeout_error
    case network_error
    case unknown_error
}

enum DowJonesStatus {
    case already_had_it
    case too_early
    case getting_it_now
    case just_got_it
    case error(_ error:DowJonesError)
}

class DowJonesDate {
    private let date:Date
    
    private let dowJonesStatus:DowJonesStatus
    
    private var dowJonesOpen:String?
    
    init(date: Date) {
        self.date = date
        
        // First, reject with an error if date < first_djia_date
        if (date < Self.first_djia_date) {
            dowJonesStatus = .error(.before_djia_existed_error)
            return
        }
        
        // Next, get the DJ Open from the cache, if it's there
        dowJonesOpen = Self.getFromCacheFor(date)
        if (dowJonesOpen != nil) {
            dowJonesStatus = .already_had_it
            return
        }
        
        // Next, if it's before the DJ opening time for that date,
        // return status .too_early
        if (date < Self.dowJonesOpenTimeFor(date)) {
            dowJonesStatus = .too_early
            return
        }
        
        // If we get here, the DJ Open should be available.
        // So let's try to get it!!!
        
        
        
        // if we get this far, we had a weird and unknown problem
        dowJonesStatus = .error(.unknown_error)
        return
    }
    
    static func dowJonesOpenTimeFor(_ date:Date) -> Date {
        
        let components = Calendar.current.dateComponents(
            [.day, .month, .year], from: date)
        
        return Calendar.current.date(
            from:DateComponents(
                timeZone: TimeZone(abbreviation: "EST"),
                year:   components.year,
                month:  components.month,
                day:    components.day,
                hour:   09,
                minute: 30,
                second: 15 // we start checking 15 seconds after 9.30.
                // See https://geohashing.site/geohashing/User_talk:Crox#How_soon_should_I_check_geo.crox.net.3F for details.
            )
        )!
    }
    
    static func getFromCacheFor(_ date:Date) -> String? {
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFullDate
        let dateString = dateFormatter.string(from: date)
        
        let defaults = UserDefaults.standard
        let openString = defaults.object(forKey:dateString) as? String
        
        return openString
    }
    
    // the first ever DJIA open price was on 1928-10-01
    static let first_djia_date = Calendar.current.date(
        from:DateComponents(
            timeZone: TimeZone(abbreviation: "EST"),
            year: 1928,
            month:  10,
            day:    01,
            hour:   00,
            minute: 00
        )
    )!
    
}

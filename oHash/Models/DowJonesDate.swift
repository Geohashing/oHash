//
//  DowJonesDate.swift
//  oHash
//
//  Created by Brendan White on 1/4/2024.
//

import Foundation
import SwiftUI
import OSLog

class DowJonesDate {
    
    var now:Date // generally set to Date.now, but can change for testing
    
    public enum DowJonesError: Equatable {
        case before_djia_existed_error
        case no_base_url_error
        case bad_calculated_url_error
        case timeout_error
        case network_error(_ httpStatus:Int)
        case urlsession_error
        case unknown_error
        case unexpected_404
        case bad_server_response(_ serverResponse:String)
    }
    
    public enum DowJonesStatus: Equatable {
        case not_yet_calculated
        case already_had_it(_ open:String)
        case too_early
        case getting_it_now
        case just_got_it(_ open:String)
        case error(_ error:DowJonesError)
    }
    
    private let date:Date
    
    private var dowJonesStatus:DowJonesStatus
    
    public var dowJonesOpen:String? {
        switch self.dowJonesStatus {
        case .already_had_it(let open):
            return open
        case .just_got_it(let open):
            return open
        default:
            return nil
        }
    }    
    
    private var iso8601String: String {
        self.date.formatted(Date.iso8601)
    }
    
    convenience init(_ s:String) {
        self.init(Date.fromISO8601String(s))
    }
    
    init(_ date: Date, now:Date = .now) {
        self.date = date
        dowJonesStatus = .not_yet_calculated
        Logger.djopen.info("creating DowJonesDate for date \(self.date.ISO8601Format())")
        self.now = now
    }
    
    
    public func getStatus() -> DowJonesStatus {
        
        // First, reject with an error if date < first_djia_date
        if (date < Self.first_djia_date) {
            self.dowJonesStatus = .error(.before_djia_existed_error)
            return self.dowJonesStatus
        }
        
        // Next, get the DJ Open from the cache, if it's there
        let cachedOpen = getFromCache()
        if (cachedOpen != nil) {
            self.dowJonesStatus = .already_had_it(cachedOpen!)
            return self.dowJonesStatus
        }
        
        // Next, if it's before the DJ opening time for that date,
        // return status .too_early
        if (now < self.dowJonesOpenTime()) {
            self.dowJonesStatus = .too_early
            return self.dowJonesStatus
        }
        
        // If we get here, the DJ Open should be available.
        // So let's try to get it!!!
        self.dowJonesStatus = .getting_it_now
        Task{
            await getDowJonesOpenFromSource()
        }
        return self.dowJonesStatus
        
    }
    
    public func getDowJonesOpenFromSource() async -> DowJonesStatus {
        
        // First, get the base URL for the open score
        guard let baseDowJonesURL = (Bundle.main.object(forInfoDictionaryKey: "baseDowJonesURL") as? String) else {
            self.dowJonesStatus = .error(.no_base_url_error)
            Logger.djopen.error("no_base_url_error")
            return self.dowJonesStatus
        }
        
        // Then, build the entire URL from the base URL plus the yyyy-mm-dd date string
        guard let url = URL(string: baseDowJonesURL + self.iso8601String) else {
            self.dowJonesStatus = .error(.bad_calculated_url_error)
            Logger.djopen.error("bad_calculated_url_error")
            return self.dowJonesStatus
        }

        Logger.djopen.info("Getting DJOpen from \(url)")

        // Then, get the response from the server
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            self.dowJonesStatus = .error(.urlsession_error)
            Logger.djopen.error("urlsession_error")
            return self.dowJonesStatus
        }
        
        // Finally, check the HTTP status code
        let httpResponse = response as! HTTPURLResponse
        switch httpResponse.statusCode {
        case 200:
            self.dowJonesStatus = statusFromData(data)
        case 404:
            if (Date.now < self.dowJonesOpenTime()) {
                self.dowJonesStatus = .too_early
            } else {
                self.dowJonesStatus = .error(.unexpected_404)
            }
        default:
            self.dowJonesStatus = .error(.network_error(httpResponse.statusCode))
        }
        Logger.djopen.info("HTTP status: \(httpResponse.statusCode)")

        // TODO: Set the environment object flag to "we've got a new response"

        return self.dowJonesStatus
        
    }
    
    private func statusFromData(_ data:Data) -> DowJonesStatus {
        let dataString = String(decoding: data, as: UTF8.self)
        Logger.djopen.info("data: \(dataString)")

        // Check it's a number
        guard let dataDouble = Double(dataString) else {
            return .error(.bad_server_response(dataString))
        }
        
        // check it's between 1.0 and max_double
        if dataDouble < 1.0 {
            return .error(.bad_server_response(dataString))
        }
        if dataDouble > Double.greatestFiniteMagnitude {
            return .error(.bad_server_response(dataString))
        }

        // If we get to here, then the server has responded with a
        // reasonable looking String, which converts nicely to a nice number.
        // Let's call this a good Dow Jones Open value.

        // Cache it in UserDefaults, in case we need it again later
        UserDefaults.standard.set(dataString, forKey: self.iso8601String)
        
        // Return this DJ Open value for use.
        return .just_got_it(dataString)

    }
    
    private func dowJonesOpenTime() -> Date {
        
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
    
    private func getFromCache() -> String? {
        UserDefaults.standard.object(forKey:self.iso8601String) as? String
    }
    
    // the first ever DJIA open price was on 1928-10-01
    public static let first_djia_date = Calendar.current.date(
        from:DateComponents(
            timeZone: TimeZone(abbreviation: "EST"),
            year: 1928,
            month:  10,
            day:    01,
            hour:   00,
            minute: 00
        )
    )!
    
    // the date from the XKCD cartoon https://xkcd.com/426/
    public static let xkcd_cartoon_date = Calendar.current.date(
        from:DateComponents(
            year: 2005,
            month:  05,
            day:    26,
            hour:   12,
            minute: 00
        )
    )!

}

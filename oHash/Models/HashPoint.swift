//
//  HashPoint.swift
//  oHash
//
//  Created by Brendan White on 15/4/2024.
//

import Foundation
import SwiftUI
import MapKit
import OSLog

struct HashPoint: Identifiable {
    let id = UUID()  // not convinced this is the best id, but it'll do for now...
    
    static let df = DateFormatter()
    
    public let date:Date
    public let graticule:Graticule
    
    public var dateText:String {
        let calendar = Calendar.current
        
        if ( calendar.isDateInToday(date) || calendar.isDateInTomorrow(date) ) {
            // If the date is today or tomorrow, write "Today" or "Tomorrow" (auto-localised)
            Self.df.dateStyle = .short
            Self.df.timeStyle = .none
            Self.df.doesRelativeDateFormatting = true
            return Self.df.string(from: date)
            
        } else if ( self.date > Date.now ) {
            // If it's in the upcoming week, write the abbreviated weekday name
            // eg Mon or Tue (auto-localised)
            return self.date.formatted(Date.FormatStyle().weekday(.abbreviated))
            
        } else {
            // Otherwise, just write the short date eg 31/12/1999 (again, auto-localised)
            Self.df.dateStyle = .short
            Self.df.timeStyle = .none
            Self.df.doesRelativeDateFormatting = false
            return Self.df.string(from: date)
        }
    }
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: graticule.bottomedge() + 0.5, longitude: graticule.leftedge() + 0.5)
    }
    
    @EnvironmentObject var state:OHashState
    
    public static func getFor(region:MKCoordinateRegion, date:Date) -> [HashPoint] {
        var points:[HashPoint] = []
        let bottomLeftGrat = Graticule(coords: region.bottomLeft)
        let topRightGrat = Graticule(coords: region.topRight)
        
        var firstGratInThisRow = bottomLeftGrat
        var thisGrat:Graticule
        
        // Loop through rows of Grats, from south to north
        repeat {
            
            // Loop through Grats in this Row, from west to east
            thisGrat = firstGratInThisRow
            repeat {
                Logger.hashpoint.info("adding \(thisGrat.latitude), \(thisGrat.longitude) to grats for region")
                points.append(HashPoint(date: date, graticule: thisGrat))
                thisGrat = thisGrat.nextGratEast()
            } while thisGrat.longitude != topRightGrat.nextGratEast().longitude
            
            firstGratInThisRow = firstGratInThisRow.nextGratNorth()
        } while firstGratInThisRow.latitude != topRightGrat.nextGratNorth().latitude
        
        return points
    }
    
    
}

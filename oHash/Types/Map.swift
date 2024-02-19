//
//  Map.swift
//  oHash
//
//  Created by Brendan White on 14/2/2024.
//

import Foundation
import SwiftUI
import MapKit

struct OhGrid {
    
    static let MAX_DELTA_FOR_1GRAT_LINES  =  15.0;
    static let MAX_DELTA_FOR_5GRAT_LINES  =  50.0;
    static let MAX_DELTA_FOR_10GRAT_LINES = 100.0;
    
    
    
    static func latLongLines(region:MKCoordinateRegion)
    -> some MapContent {
        
        var minDelta: Double {
            Double.minimum(
                region.span.latitudeDelta,
                region.span.longitudeDelta
            )
        }
        
        func colorFor(number:Int) -> Color {
            
            if number.isMultiple(of: 10) {
                // Every tenth line is the primary color
                // and is displayed at every zoom level
                return minDelta < MAX_DELTA_FOR_10GRAT_LINES ? Color.primary : Color.clear
            }
            
            else if number.isMultiple(of: 5) {
                // Every fifth line is the accent color
                // but is only displayed when zoomed in a bit
                return minDelta < MAX_DELTA_FOR_5GRAT_LINES ? Color.accentColor : Color.clear
            }
            
            else {
                // The remaining lines are also the accent color
                // but are only displayed when zoomed in a lot
                return minDelta < MAX_DELTA_FOR_1GRAT_LINES ? Color.accentColor : Color.clear
            }
            
        } // end func colorFor
        
        return (
            
            
            ForEach(0..<180) { number in
                
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(number-90), longitude: 180
                    ),
                    CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(number-90), longitude: 0
                    )
                ])
                .stroke(colorFor(number:number))
                
                
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(number-90), longitude: -180
                    ),
                    CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(number-90), longitude: 0
                    )
                ])
                .stroke(colorFor(number:number))
                
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude: -90, longitude: CLLocationDegrees(0-number)
                    ),
                    CLLocationCoordinate2D(
                        latitude: 90, longitude: CLLocationDegrees(0-number)
                    )
                ])
                .stroke(colorFor(number:number))
                
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude: -90, longitude: CLLocationDegrees(0+number)
                    ),
                    CLLocationCoordinate2D(
                        latitude: 90, longitude: CLLocationDegrees(0+number)
                    )
                ])
                .stroke(colorFor(number:number))
                
            }
        )
    } // end func
    
} // end extension

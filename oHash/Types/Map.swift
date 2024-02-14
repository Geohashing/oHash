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
    
    static func latLongLines(
        latitudeDelta:Double, longitudeDelta:Double
    ) -> some MapContent {
        
        var minDelta: Double {
            Double.minimum(latitudeDelta,longitudeDelta)
        }
        
        func colorFor(number:Int) -> Color {
            
            if number.isMultiple(of: 10) {
                // Every tenth line is the primary color
                // and is displayed at every zoom level
                return Color.primary
            } 
            
            else if number.isMultiple(of: 5) {
                // Every fifth line is the accent color
                // but is only displayed when zoomed in a bit
                return minDelta < 50 ? Color.accentColor : Color.clear
            }
            
            else {
                // The remaining lines are also the accent color
                // but are only displayed when zoomed in a lot
                return minDelta < 15 ? Color.accentColor : Color.clear
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
    
    static func longLines(
        latitudeDelta:Double, longitudeDelta:Double
    ) -> some MapContent {
        
        
        
        
        
        ForEach(0..<180) { number in
            
            

            
            
        } // end ForEach
        
        
        
        
        
    } // end func
    
} // end extension
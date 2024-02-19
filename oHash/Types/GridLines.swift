//
//  GridLines.swift
//  oHash
//
//  Created by Brendan White on 20/2/2024.
//

import Foundation
import SwiftUI
import MapKit

struct GridLines: MapContent {
    let region: MKCoordinateRegion
            
    static let MAX_DELTA_FOR_1GRAT_LINES  =  15.0;
    static let MAX_DELTA_FOR_5GRAT_LINES  =  50.0;
    static let MAX_DELTA_FOR_10GRAT_LINES = 100.0;
    
    var minDelta: Double {
        Double.minimum(
            region.span.latitudeDelta,
            region.span.longitudeDelta
        )
    }


    @MapContentBuilder
    var body: some MapContent {
        if minDelta < Self.MAX_DELTA_FOR_10GRAT_LINES {
            
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 180
                ),
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 0
                )
            ])
            .stroke(Color.red)
            
            
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: -180
                ),
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 0
                )
            ])
            .stroke(Color.green)
            
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude: -90, longitude: CLLocationDegrees(0)
                ),
                CLLocationCoordinate2D(
                    latitude: 90, longitude: CLLocationDegrees(0)
                )
            ])
            .stroke(Color.blue)
            
            
            
        } else {

            
            
            
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 180
                ),
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 0
                )
            ])
            .stroke(Color.black)
            
            
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: -180
                ),
                CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(0), longitude: 0
                )
            ])
            .stroke(Color.white)
            
            
            
            
        }
    }
}

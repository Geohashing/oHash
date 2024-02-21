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
  
    var minDelta: Double {
        Double.minimum(
            region.span.latitudeDelta,
            region.span.longitudeDelta
        )
    }
        
    
    func latitudeRange() -> Range<Double> {
        let northernLatitude = (Double(region.center.latitude) - Double(region.span.latitudeDelta))
        let southernLatitude = (Double(region.center.latitude) + Double(region.span.latitudeDelta))
        return (northernLatitude..<southernLatitude)
    }
    
    func longitudeRange() -> Range<Double> {
        let westernLongitude = (Double(region.center.longitude) - Double(region.span.longitudeDelta))
        let easternLongitude = (Double(region.center.longitude) + Double(region.span.longitudeDelta))
        return (westernLongitude..<easternLongitude)
    }
            
    func colorForNumber(_ n:Int) -> Color {
        return n.isMultiple(of: 5) ? Color.primary : Color.accentColor
    }
    
    
    
    @MapContentBuilder
    var allGratLines: some MapContent {
        
        let northernmostLatitude = Int(Double(region.center.latitude) - Double(region.span.latitudeDelta))
        let southernmostLatitude = Int(Double(region.center.latitude) + Double(region.span.latitudeDelta))
        
        let westernmostLongitude = Int(Double(region.center.longitude) - Double(region.span.longitudeDelta))
        let easternmostLongitude = Int(Double(region.center.longitude) + Double(region.span.longitudeDelta))
        
        
        // Draw Latitude lines
        ForEach(northernmostLatitude...southernmostLatitude, id: \.self) {
            thisLat in
            
            // Draw Latitude line in Western hemisphere
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude:CLLocationDegrees(thisLat), longitude: -180
                ),
                CLLocationCoordinate2D(
                    latitude:CLLocationDegrees(thisLat), longitude: 0
                )
            ]).stroke(colorForNumber(thisLat))
            
            // Draw Latitude line in Eastern hemisphere
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude:CLLocationDegrees(thisLat), longitude: 0
                ),
                CLLocationCoordinate2D(
                    latitude:CLLocationDegrees(thisLat), longitude: +180
                )
            ]).stroke(colorForNumber(thisLat))
            
        } // end ForEach latitude
        
        // Draw Longitude lines
        ForEach(westernmostLongitude...easternmostLongitude, id: \.self) {
            thisLong in
            
            // Longitude line in Northern hemisphere
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude:-90, longitude: CLLocationDegrees(thisLong)
                ),
                CLLocationCoordinate2D(
                    latitude: 0, longitude: CLLocationDegrees(thisLong)
                )
            ]).stroke(colorForNumber(thisLong))
            
            //                         Longitude line in Southern hemisphere
            MapPolyline(coordinates:[
                CLLocationCoordinate2D(
                    latitude:0, longitude: CLLocationDegrees(thisLong)
                ),
                CLLocationCoordinate2D(
                    latitude: +90, longitude: CLLocationDegrees(thisLong)
                )
            ]).stroke(colorForNumber(thisLong))
            
        } // end ForEach longitude
        
    } // end allGratLines
    
    
    let firstEveryFiveLat  = -85.0 // ie 85° South
    let lastEveryFiveLat   = +85.0 // ie 85° North
    
    let firstEveryFiveLong = -180.0 // ie 180° West
    let lastEveryFiveLong  = +175.0 // ie 175° East

    @MapContentBuilder
    var everyFiveGratLines: some MapContent {
        
        // Draw Latitude lines
        ForEach(Array(stride(from: firstEveryFiveLat, to: lastEveryFiveLat, by: 5.0)), id: \.self) {
            thisLat in
            
            if latitudeRange().contains(thisLat) {
                    // Draw Latitude line in Western hemisphere
                    MapPolyline(coordinates:[
                        CLLocationCoordinate2D(
                            latitude:thisLat, longitude: -180
                        ),
                        CLLocationCoordinate2D(
                            latitude: thisLat, longitude: 0
                        )
                    ]).stroke(Color.primary)
                    
                    // Draw Latitude line in Eastern hemisphere
                    MapPolyline(coordinates:[
                        CLLocationCoordinate2D(
                            latitude:thisLat, longitude: 0
                        ),
                        CLLocationCoordinate2D(
                            latitude: thisLat, longitude: 180
                        )
                    ]).stroke(Color.primary)
            } // end if latitudeRange contains thisLat
            
        } // end Latitude lines
        
        // Draw Longitude lines
        ForEach(Array(stride(from: firstEveryFiveLong, to: lastEveryFiveLong, by: 5.0)), id: \.self) {
            thisLong in
            
            if longitudeRange().contains(thisLong) {
                // Longitude line in Northern hemisphere
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude:-90, longitude: thisLong
                    ),
                    CLLocationCoordinate2D(
                        latitude: 0, longitude: thisLong
                    )
                ]).stroke(Color.primary)
                
                // Longitude line in Southern hemisphere
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude:0, longitude: thisLong
                    ),
                    CLLocationCoordinate2D(
                        latitude: +90, longitude: thisLong
                    )
                ]).stroke(Color.primary)
            } // end if longitudeRange contains thisLong
            
        } // end Longitude lines

        
    } // end var everyFiveGratLines
    
    let firstEveryTenLat  = -80.0 // ie 80° South
    let lastEveryTenLat   = +80.0 // ie 80° North

    let firstEveryTenLong = -180.0 // ie 180° West
    let lastEveryTenLong  = +170.0 // ie 170° East

    @MapContentBuilder
    var everyTenGratLines: some MapContent {
                
        // Draw Latitude lines
        ForEach(Array(stride(from: firstEveryTenLat, to: lastEveryTenLat, by: 10.0)), id: \.self) {
            thisLat in
            
            if latitudeRange().contains(thisLat) {
                    // Draw Latitude line in Western hemisphere
                    MapPolyline(coordinates:[
                        CLLocationCoordinate2D(
                            latitude:thisLat, longitude: -180
                        ),
                        CLLocationCoordinate2D(
                            latitude: thisLat, longitude: 0
                        )
                    ]).stroke(Color.primary)
                    
                    // Draw Latitude line in Eastern hemisphere
                    MapPolyline(coordinates:[
                        CLLocationCoordinate2D(
                            latitude:thisLat, longitude: 0
                        ),
                        CLLocationCoordinate2D(
                            latitude: thisLat, longitude: 180
                        )
                    ]).stroke(Color.primary)
            } // end if latitudeRange contains thisLat
            
        } // end Latitude lines
        
        // Draw Longitude lines
        ForEach(Array(stride(from: firstEveryTenLong, to: lastEveryTenLong, by: 10.0)), id: \.self) {
            thisLong in
            
            if longitudeRange().contains(thisLong) {
                // Longitude line in Northern hemisphere
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude:-90, longitude: thisLong
                    ),
                    CLLocationCoordinate2D(
                        latitude: 0, longitude: thisLong
                    )
                ]).stroke(Color.primary)
                
                // Longitude line in Southern hemisphere
                MapPolyline(coordinates:[
                    CLLocationCoordinate2D(
                        latitude:0, longitude: thisLong
                    ),
                    CLLocationCoordinate2D(
                        latitude: +90, longitude: thisLong
                    )
                ]).stroke(Color.primary)
            } // end if longitudeRange contains thisLong
            
        } // end Longitude lines
        
    } // end var everyTenGratLines
    
    static let MAX_DELTA_FOR_1GRAT_LINES  =  15.0;
    static let MAX_DELTA_FOR_5GRAT_LINES  =  50.0;
    static let MAX_DELTA_FOR_10GRAT_LINES = 100.0;
    
    @MapContentBuilder
    var body: some MapContent {
        
        switch minDelta {
        case 0.0...Self.MAX_DELTA_FOR_1GRAT_LINES:
            allGratLines

        case Self.MAX_DELTA_FOR_1GRAT_LINES...Self.MAX_DELTA_FOR_5GRAT_LINES:
            everyFiveGratLines

        case Self.MAX_DELTA_FOR_5GRAT_LINES...Self.MAX_DELTA_FOR_10GRAT_LINES:
            everyTenGratLines

        default:
            EmptyMapContent.init()
        } // end switch
        
    } // end body
    
    


}

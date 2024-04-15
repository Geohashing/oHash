//
//  HashPointMarkers.swift
//  oHash
//
//  Created by Brendan White on 15/4/2024.
//

import Foundation
import SwiftUI
import MapKit

struct HashPointMarkers: MapContent {
    let region: MKCoordinateRegion
    @EnvironmentObject var state:OHashState
    
    static let MAX_DELTA_FOR_HASHPOINTS      =  4.0
    
    var body: some MapContent {
        
        switch region.minDelta {
            
        case 0.0..<Self.MAX_DELTA_FOR_HASHPOINTS:
            
            // 34.839422, 134.694044 - Himeji Castle
            Marker(".background", coordinate: CLLocationCoordinate2D(latitude: 34.839422, longitude: 134.694044))
                .tint(.background) // white in light mode, black in dark mode
            
            // 34.982543, 135.750621 - Tōji
            Marker("foreground", coordinate: CLLocationCoordinate2D(latitude: 34.982543, longitude: 135.750621))
                .tint(.foreground)
            
            // 34.665933, 135.431310 - USJ
            Marker("accent", coordinate: CLLocationCoordinate2D(latitude: 34.665933, longitude: 135.431310))
                .tint(.accent)
            
        default: EmptyMapContent.init()
            
        }
    }
}

#Preview {
    ContentView()
}

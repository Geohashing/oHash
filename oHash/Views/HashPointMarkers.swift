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
    
    private func isSelected(_ graticule:Graticule) -> Bool {
        //        (state.haveSelectedAGrat) && TODO: Put this back in, when we are reliably setting state.haveSelectedAGrat
        (graticule.key == state.selectedGraticule.key)
    }
    
    private func tintFor(_ hashpoint:HashPoint) -> some ShapeStyle {
        
        if ( Calendar.current.isDate(hashpoint.date, equalTo: state.selectedDate, toGranularity: .day) ){
            
            // This is the selected date. It needs to be .accent color (or .accentBackground).
            return isSelected(hashpoint.graticule)
            ? Color.accent
            : Color.clear // or .accentBackground
            
        } else {
            
            // This is NOT the selected date. It should be regular .primary (or .background).
            return isSelected(hashpoint.graticule)
            ? Color(uiColor:.label)
            : Color(uiColor:.systemBackground)
            
        }
        
    }
    
    var body: some MapContent {
        
        switch region.minDelta {
            
        case 0.0..<Self.MAX_DELTA_FOR_HASHPOINTS:
            
            ForEach(HashPoint.forRegion(region)) { hashpoint in
                Marker(
                    hashpoint.date.ISO8601Format(Date.iso8601),
                    coordinate: hashpoint.coordinate
                )
                .tint(tintFor(hashpoint))
            }
            
        default: EmptyMapContent.init()
            
        }
    }
}

#Preview {
    ContentView()
}

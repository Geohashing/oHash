//
//  OHashMap.swift
//  oHash
//
//  Created by Brendan White on 14/4/2024.
//

import SwiftUI
import MapKit

struct OHashMap: View {
    @EnvironmentObject var state:OHashState
    
    var body: some View {

        MapReader { proxy in
            Map(
                initialPosition: MapCameraPosition.region(state.mapRegion),
                interactionModes: [.pan, .zoom, .rotate]
            ){
                GridLines(region: state.mapRegion)
                HashPointMarkers(region: state.mapRegion)
            }
            .onTapGesture {
                position in
                
                state.selectedGraticule = Graticule(
                    coords: proxy.convert(position, from: .local) ??  CLLocationCoordinate2D.init()
                )
                state.tapText = "map tap on \(state.selectedGraticule.latitude), \(state.selectedGraticule.longitude)"
            }
            .onMapCameraChange { mapCameraUpdateContext in
                state.mapRegion = mapCameraUpdateContext.region
            }
        }

    }
}

#Preview {
    OHashMap()
}

//
//  HashPoint.swift
//  oHash
//
//  Created by Brendan White on 15/4/2024.
//

import Foundation
import SwiftUI
import MapKit

struct HashPoint: Identifiable {
    let id = UUID()  // not convinced this is the best id, but it'll do for now...
    
    public let date:Date
    public let graticule:Graticule
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: graticule.bottomedge() + 0.5, longitude: graticule.leftedge() + 0.5)
    }

    @EnvironmentObject var state:OHashState

    public static func forRegion(_ region:MKCoordinateRegion) -> [HashPoint] {
        return [ 

            HashPoint( date:Date.now, graticule: Graticule(coords: region.center) ),

            HashPoint( date:Date.now, graticule: Graticule(coords: region.center).nextGratEast()  ),
            HashPoint( date:Date.now, graticule: Graticule(coords: region.center).nextGratWest()  ),
            HashPoint( date:Date.now, graticule: Graticule(coords: region.center).nextGratNorth() ),
            HashPoint( date:Date.now, graticule: Graticule(coords: region.center).nextGratSouth() ),

        ]
    }
    
    
}

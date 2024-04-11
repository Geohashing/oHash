//
//  Graticule.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation
import MapKit
import OSLog

struct Graticule: RawRepresentable {
    
    // The internal x,y coordinates start
    // at 0,0 in the southwest corner
    // of the standard Mercator projection,
    // and go to 359,179 in the northeast.
    
    private var internal_x:Int, internal_y:Int
    
    public var coords: [Int] {
        return [internal_x, internal_y]
    }
    
    // Are we in the Eastern hemisphere or the Western?
    public var isEast:Bool {
        internal_x >= 180
    }
    public var isWest:Bool {
        !isEast
    }
    
    // Are we in the Northern hemisphere or the Southern?
    public var isNorth:Bool {
        internal_y >= 90
    }
    public var isSouth:Bool {
        !isNorth
    }
    
    // Publicly visible "Longitude" string
    public var longitude:String {
        if isEast {
            String( internal_x - 180 )
        } else {
            "- " + String ( abs(internal_x - 179) )
        }
    }
    
    // Publicly visible "Latitude" string
    public var latitude:String {
        if ( isNorth ) {
            String( internal_y - 90 )
        } else {
            "- " + String ( abs(internal_y - 89) )
        }
    }
    
    private static let x_count = 360
    private static let min_x:Int = 0
    private static let max_x:Int = x_count - 1
    private static let x_range = min_x...max_x
    
    private static let y_count = 180
    private static let min_y:Int = 0
    private static let max_y:Int = y_count - 1
    private static let y_range = min_y...max_y
    
    public var key:Int {
        // The key is an Int that uniquely identifies the Graticule.
        // If y=0, then the key is x, so 0 through 359.
        // If y=1, then the key is 360 + x, so 360 through 719.
        // If y=2, then the key is 720 + x, so 720 through 1079.
        // And so on. For any vaue of y, the key is (y*360) + x, so (y*360) through (y*360)+359.
        
        return (internal_y * Self.x_count) + internal_x
    }
    
    // rawValue getter & setter to make the Graticule type RawRepresentable
    public init?(rawValue: Int) {
        self = Graticule(key: rawValue)
    }
    public var rawValue: Int {
        self.key
    }
    
    init(internal_x:Int, internal_y:Int) {
        
        // To ensure x is in 0...359,
        // we add 360 to it then take the remainder
        // when dividing by 360.
        self.internal_x = ( internal_x + Self.x_count ) % Self.x_count
        
        // Same with y in 0...179
        self.internal_y = ( internal_y + Self.y_count ) % Self.y_count
        
    }
    
    init(key:Int) {
        self.init(
            
            // To get x from the key,
            // divide it by 360
            // and take the bit left over.
            
            // So if the key is 729, then
            // we divide 729 by 360,
            // and we get 2 times 360 (which is 720)
            // with 9 left over.
            
            // So if the key is 729, then x is 9.
            internal_x: key % Self.x_count,
            
            // To get Y from the key,
            // divide the key by 360
            // and throw away the remainder
            internal_y: key / Self.x_count
            
        )
    }
    
    private init( doubleLongitude:Double, doubleLatitude:Double ) {
        
        // first, get internal_x from doubleLongitude
        if ( doubleLongitude == -180 ) {
            internal_x = 0
        } else if ( doubleLongitude == +180 ) {
            internal_x = 359
        } else if ( doubleLongitude < 0.0 ) {
            // we are West of the GMT meridian
            internal_x = Int(doubleLongitude) + 179
        } else {
            // we are East of the GMT meridian
            internal_x = Int(doubleLongitude) + 180
        }
        
        // then, get internal_y from doubleLatitude
        if ( doubleLatitude == -90 ) {
            internal_y = 0
        } else if ( doubleLatitude == +90 ) {
            internal_y = 179
        } else if ( doubleLatitude < 0.0 ) {
            // we are South of the equator
            internal_y = Int(doubleLatitude) + 89
        } else {
            // we are North of the equator
            internal_y = Int(doubleLatitude) + 90
        }
    }
    
    public init(coords:CLLocationCoordinate2D) {
        Logger.graticule.info("from CLLocationCoordinate2D lat \(coords.latitude) \(Int(coords.latitude)), long \(coords.longitude) \(Int(coords.longitude))")
        self.init(
            doubleLongitude: Double(coords.longitude),
            doubleLatitude: Double(coords.latitude)
        )
    }
    
    public init(mapPoint:MKMapPoint) {
        Logger.graticule.info("from MKMapPoint lat \(mapPoint.y), long \(mapPoint.x)")
        self.init(
            doubleLongitude: Double(mapPoint.x),
            doubleLatitude: Double(mapPoint.y)
        )
    }
    
    public func topedge() -> Double {
        Double ( (self.internal_y+1) - 90 )
    }
    public func bottomedge() -> Double {
        Double ( self.internal_y - 90 )
    }
    public func leftedge() -> Double {
        Double ( self.internal_x - 180 )
    }
    public func rightedge() -> Double {
        Double ( (self.internal_x+1) - 180 )
    }
    
    public func nextGratSouth() -> Graticule {
        if internal_y == Self.min_y {
            self // can't go further south than here
        } else {
            Graticule(internal_x:internal_x, internal_y:internal_y-1)
        }
    }
    public func nextGratNorth() -> Graticule {
        if internal_y == Self.max_y {
            self // can't go further north than here
        } else {
            Graticule(internal_x:internal_x, internal_y:internal_y+1)
        }
    }
    public func nextGratWest() -> Graticule {
        Graticule(internal_x:internal_x-1, internal_y:internal_y)
    }
    public func nextGratEast() -> Graticule {
        Graticule(internal_x:internal_x+1, internal_y:internal_y)
    }
    
}


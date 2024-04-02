//
//  Graticule.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation
import MapKit

struct Graticule {
    
    // The x,y coordinates start
    // at 0,0 in the northwest corner
    // of the standard Mercator projection,
    // and go to 359,179 in the southeast.
    
    var x:Int, y:Int
    
    public static let x_count = 360
    public static let min_x:Int = 0
    public static let max_x:Int = x_count - 1
    public static let x_range = min_x...max_x
    
    public static let y_count = 180
    public static let min_y:Int = 0
    public static let max_y:Int = y_count - 1
    public static let y_range = min_y...max_y
    
    public var key:Int {
        // The key is an Int that uniquely identifies the Graticule.
        // If y=0, then the key is x, so 0 through 359.
        // If y=1, then the key is 360 + x, so 360 through 719.
        // If y=2, then the key is 720 + x, so 720 through 1079.
        // And so on. For any vaue of y, the key is (y*360) + x, so (y*360) through (y*360)+359.
        
        return (y * Self.x_count) + x
    }
    
    public static let NO_GRATICULE_SELECTED_KEY = -1    // TODO: is this the way to handle "no graticule"???
    
    
    init(x:Int, y:Int) {
        // To ensure x is in 0...359,
        // we add 360 to it then take the remainder
        // when dividing by 360.
        self.x = ( x + Self.x_count ) % Self.x_count
        // Same with y in 0...179
        self.y = ( y + Self.y_count ) % Self.y_count
    }
    
    init(key:Int) {
        self.init(
            x: key % Self.x_count,
            y: key / Self.x_count
        )
    }
        
    init(p:MKMapPoint) {
        self.init(
            x: p.x == +180.0 ? 359 : Int( p.x + 180 ),
            y: p.y ==  +90.0 ? 179 : Int( p.y +  90 )
        )
    }
    
    public func region() -> MKCoordinateRegion {
        return MKCoordinateRegion(MKMapRect(
            // to build the MKMapRect, we need the x,y of the CENTRE of the graticule
            x: leftedge() + 0.5,
            y: topedge() + 0.5,
            width: 1, height: 1
        ))
    }
    
    
    public func topedge() -> Double {
        Double ( self.y - 90 )
    }
    public func bottomedge() -> Double {
        Double ( (self.y+1) - 90 )
    }
    public func leftedge() -> Double {
        Double ( self.x - 180 )
    }
    public func rightedge() -> Double {
        Double ( (self.x+1) - 180 )
    }
    
    public func north() -> Graticule {
        if y == Self.min_y {
            self // can't go further north than here
        } else {
            Graticule(x:x, y:y-1)
        }
    }
    public func south() -> Graticule {
        if y == Self.max_y {
            self // can't go further south than here
        } else {
            Graticule(x:x, y:y+1)
        }
    }
    public func west() -> Graticule {
        Graticule(x:x-1, y:y)
    }
    public func east() -> Graticule {
        Graticule(x:x+1, y:y)
    }
    
}

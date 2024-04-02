//
//  Graticule.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation

struct Graticule {
    
    var x:Int, y:Int

    public static let x_count = 360
    public static let min_x:Int = 0
    public static let max_x:Int = x_count - 1
    public static let x_range = min_x...max_x

    public static let y_count = 180
    public static let min_y:Int = 0
    public static let max_y:Int = y_count - 1
    public static let y_range = min_y...max_y
    
    private static let x_factor:Int = 1024

    public var key:Int {
        (x * Self.x_factor) + y
    }

    public static let NO_GRATICULE_SELECTED = -1
    
    
    
    init(key:Int) {
        self.init(
            x: key / Self.x_factor, 
            y: key % Self.x_factor
        )
    }
    
    init(x:Int, y:Int) {
        // To ensure x is in 0...359,
        // we add 360 to it then take the remainder
        // when dividing by 360.
        self.x = ( x + Self.x_count ) % Self.x_count
        // Same with y in 0...179
        self.y = ( y + Self.y_count ) % Self.y_count
    }
    
}

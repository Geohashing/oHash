//
//  GraticuleTests.swift
//  oHashTests
//
//  Created by Brendan White on 3/4/2024.
//

import XCTest
import MapKit
@testable import oHash

final class GraticuleTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateFromKey() throws {
        
        // the key should be (y*360) + x
        XCTAssertEqual( Graticule(key:            0).key,           0, "key 0"           )
        XCTAssertEqual( Graticule(key:          359).key,         359, "key 359"         )
        XCTAssertEqual( Graticule(key: (180*360)-1 ).key, (180*360)-1, "key (180*360)-1" )
        
    }
    
    func testCreateFromXY() throws {
        
        XCTAssertEqual( Graticule(x:   0, y:   0).coords, [  0,  0], "xy [  0,  0]" )
        XCTAssertEqual( Graticule(x:   0, y: 179).coords, [  0,179], "xy [  0,179]" )
        XCTAssertEqual( Graticule(x: 359, y:   0).coords, [359,  0], "xy [359,  0]" )
        XCTAssertEqual( Graticule(x: 359, y: 179).coords, [359,179], "xy [359,179]" )
        
    }
    
    func testCreateFromMapPoint() throws {
        
        // Latitude,Longitude of -180,-90 is the    top-left  of graticule   0,  0.
        // Latitude,Longitude of    0,  0 is the    top-left  of graticule 180, 90.
        // Latitude,Longitude of  180, 90 is the bottom-right of graticule 359,179.
        
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x: -180.00, y: -90.00)).coords, [  0,  0], "coords x: -180.00, y: -360.00" )
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x: -179.99, y: -89.99)).coords, [  0,  0], "coords x: -179.99, y: -359.99" )
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x:   -0.01, y:  -0.01)).coords, [179, 89], "coords x:   -0.01, y:   -0.01" )
        
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x:   0.00, y:    0.00)).coords, [180, 90], "coords x:    0.00, y:    0.00" )
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x: 179.99, y:   89.99)).coords, [359,179], "coords x:  179.99, y:   89.99" )
        XCTAssertEqual( Graticule(mapPoint: MKMapPoint(x: 180.00, y:   90.00)).coords, [359,179], "coords x:  180.00, y:   90.00" )
        
    }
    
    func testNorthSouthEastWest() throws {
        
        XCTAssertEqual( Graticule(x:   0, y:   0).north().coords, [  0,  0], "North from x:   0, y:   0" )
        XCTAssertEqual( Graticule(x:   0, y:   0).west().coords,  [359,  0], "West  from x:   0, y:   0" )
        
        XCTAssertEqual( Graticule(x:   0, y: 179).west().coords,  [359,179], "West  from x:   0, y: 179" )
        XCTAssertEqual( Graticule(x:   0, y: 179).south().coords, [  0,179], "South from x:   0, y: 179" )
        
        XCTAssertEqual( Graticule(x: 179, y:  89).south().coords, [179, 90], "South from x: 179, y:  89" )
        XCTAssertEqual( Graticule(x: 179, y:  89).east().coords,  [180, 89], "East  from x: 179, y:  89" )
        XCTAssertEqual( Graticule(x: 180, y:  90).north().coords, [180, 89], "North from x: 180, y:  90" )
        XCTAssertEqual( Graticule(x: 180, y:  90).west().coords,  [179, 90], "West  from x: 180, y:  90" )
        
        XCTAssertEqual( Graticule(x: 359, y:   0).north().coords, [359,  0], "North from x: 359, y:   0" )
        XCTAssertEqual( Graticule(x: 359, y:   0).east().coords,  [  0,  0], "East  from x: 359, y:   0" )
        
        XCTAssertEqual( Graticule(x: 359, y: 179).east().coords,  [  0,179], "East  from x: 359, y: 179" )
        XCTAssertEqual( Graticule(x: 359, y: 179).south().coords, [359,179], "South from x: 359, y: 179" )
        
    }
    
    func testEdges() throws {
        
        XCTAssertEqual( Graticule(x: 0, y: 0).topedge(),    -90.0, "topedge    from x: 0, y: 0")
        XCTAssertEqual( Graticule(x: 0, y: 0).bottomedge(), -89.0, "bottomedge from x: 0, y: 0")
        XCTAssertEqual( Graticule(x: 0, y: 0).leftedge(),  -180.0, "leftedge   from x: 0, y: 0")
        XCTAssertEqual( Graticule(x: 0, y: 0).rightedge(), -179.0, "rightedge  from x: 0, y: 0")
        
        XCTAssertEqual( Graticule(x: 359, y: 179).topedge(),    89.0, "topedge    from x: 359, y: 179")
        XCTAssertEqual( Graticule(x: 359, y: 179).bottomedge(), 90.0, "bottomedge from x: 359, y: 179")
        XCTAssertEqual( Graticule(x: 359, y: 179).leftedge(),  179.0, "leftedge   from x: 359, y: 179")
        XCTAssertEqual( Graticule(x: 359, y: 179).rightedge(), 180.0, "rightedge  from x: 359, y: 179")
        
    }
    
}

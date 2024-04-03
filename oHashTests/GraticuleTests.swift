//
//  GraticuleTests.swift
//  oHashTests
//
//  Created by Brendan White on 3/4/2024.
//

import XCTest
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

}

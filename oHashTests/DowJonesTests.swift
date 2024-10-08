//
//  DowJonesTests.swift
//  oHashTests
//
//  Created by Brendan White on 4/2/2024.
//

import XCTest
@testable import oHash

final class DowJonesTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Clear all UserDefaults
        UserDefaults.standard.dictionaryRepresentation().keys
            .forEach(UserDefaults.standard.removeObject(forKey:))
        UserDefaults.standard.synchronize()
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func testBasicDowJonesDates() throws {
        
        XCTAssertEqual(
            DowJonesDate.init("1900-01-01").getStatus(),
            .error(.before_djia_existed_error),
            "DJIA didn't exist in 1900"
        )
        
        XCTAssertEqual(
            DowJonesDate.init("2999-12-31").getStatus(),
            .too_early,
            "Too early to get DJIA for 2999"
        )
        
        // If we somehow have a future date cached...
        UserDefaults.standard.set("1234.5", forKey: "2999-12-31")
        // ... then it shoud be returned.
        XCTAssertEqual(
            DowJonesDate.init("2999-12-31").getStatus(),
            .already_had_it("1234.5"),
            "future date, but we had it cached"
        )
        
    }
    
    func testTrickyDowDonesDates() async throws {
        
        // Check the async networking stuff
        let theDJD = DowJonesDate.init("1980-01-01")
        XCTAssertEqual(
            theDJD.getStatus(),
            .getting_it_now,
            "Just triggered the Get, not finished yet"
        )
        // Then do the async network call
        let theStatus = await theDJD.getDowJonesOpenFromSource()
        XCTAssertEqual(
            theStatus,
            .just_got_it("838.91"),
            "async network call should be done now"
        )
        // Now check it's cached
        XCTAssertEqual(
            theDJD.getStatus(),
            .already_had_it("838.91"),
            "should already have it this time"
        )

        
    }
    
}

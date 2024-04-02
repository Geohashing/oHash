//
//  OHashState.swift
//  oHash
//
//  Created by Brendan White on 2/4/2024.
//

import Foundation
import SwiftUI
import OSLog
import MapKit

class OHashState {
    
    var displayDates: [HashDate] = []
    
    // Can't (yet) store a Date directly in @AppStorage
    // So for now, we need to store the timeIntervalSinceReferenceDate
    // and get/set a computed property
    
    // We will default to the date of the original XKCD cartoon
    @AppStorage("retrodate") var storedRetroDate = DowJonesDate.xkcd_cartoon_date
        .timeIntervalSinceReferenceDate
    var retroDate: Date {
        set {storedRetroDate = newValue.timeIntervalSinceReferenceDate}
        get {return Date(timeIntervalSinceReferenceDate: storedRetroDate)}
    }

    // Also can't store a Graticule directly in @AppStorage
    // so we'll store its key and again get/set a computed property
    @AppStorage("selected-grat") var storedSelectedGraticule = Graticule.NO_GRATICULE_SELECTED
    var selectedGraticule: Graticule {
        set {storedSelectedGraticule = newValue.key}
        get {return Graticule(key: storedSelectedGraticule)}
    }

    @AppStorage("retrohash") var retroHash: Bool = false
    
    var isCurrentlyGettingDJOpen:Bool = false
    var mapRegion: MKCoordinateRegion
    
    init(){
        mapRegion = MKCoordinateRegion() // TODO - get this from UserDefaults
    }
    
    public func selectedDate() -> Date {
        if retroHash {
            return Date.now
        } else {
            return Date.now
        }
    }
    
    public func getMapAnnotations(){
        // TODO - write code!
    }
    
}

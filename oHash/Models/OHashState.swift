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
    
    // We wil generally set today to be Date.now, but it can change for testing
    var today:Date

    // We can use MKCoordinateRegion with @AppStorage because we extended it to be RawRepresentable
    @AppStorage("map-region") var mapRegion = MKCoordinateRegion.init(MKMapRect.world)

    // Bool was always RawRepresentable.
    @AppStorage("retrohash") var retroHash: Bool = false

    
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
    @AppStorage("selected-grat") var storedSelectedGraticule = Graticule.NO_GRATICULE_SELECTED_KEY
    var selectedGraticule: Graticule? {
        set { storedSelectedGraticule = newValue?.key ?? Graticule.NO_GRATICULE_SELECTED_KEY }
        get {
            storedSelectedGraticule == Graticule.NO_GRATICULE_SELECTED_KEY
            ? nil
            : Graticule(key: storedSelectedGraticule)
        }
    }
    
    var isCurrentlyGettingDJOpen:Bool = false
        
    init(today:Date = .now){
        mapRegion = MKCoordinateRegion() // TODO - get this from UserDefaults
        self.today = today
    }
    
    public func selectedDate() -> Date {
        if retroHash {
            return retroDate
        } else {
            return today
        }
    }
    
}

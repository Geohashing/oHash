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

class OHashState: ObservableObject {
    
    // We wil generally set self.today to be Date.now, but it can change for testing
    private var today:Date
    
    // We can use MKCoordinateRegion with @AppStorage because we extended it to be RawRepresentable
    @AppStorage("map-region") public var mapRegion = MKCoordinateRegion.init(MKMapRect.world)
    
    // Bool was always RawRepresentable.
    @AppStorage("retro-hash-mode-flag") public var retroHashModeFlag: Bool = false
    
    // We extended the Date type to be RawRepresentable
    // We will default to the date of the original XKCD cartoon
    @AppStorage("retro-date") public var selectedRetroDate = DowJonesDate.xkcd_cartoon_date
    
    // Also need to store the selected "current" date
    @AppStorage("current-date") public var selectedCurrentDate = Date.now
    
    public var selectedDate:Date {
        self.retroHashModeFlag ? self.selectedRetroDate : self.selectedCurrentDate
    }
    
    // we made Graticule RawRepresentable
    @AppStorage("selected-grat") public var selectedGraticule = Graticule(mapPoint: MKMapPoint(x:0,y:0))
    
    public var isCurrentlyGettingDJOpen:Bool = false
    
    init(today:Date = .now){
        
        self.today = today
        
        // If the stored "current" date is before today,
        // then reset the stored "current" date to be today.
        if ( self.selectedCurrentDate < self.today ) {
            self.selectedCurrentDate = self.today
        }
        
    }
    
}

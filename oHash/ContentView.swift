//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit
import OSLog

import UIKit

struct ContentView: View {
    
    @StateObject var state = OHashState()
    
    @Environment(\.horizontalSizeClass) var horizontalSize
    @Environment(\.verticalSizeClass) var verticalSize
    
    var body: some View {

        if ( verticalSize == .compact) {
            // Phone in Landscape mode
            HStack {
                OHashMap().environmentObject(state)
                InfoGrid().environmentObject(state).fixedSize()

            }
        }
        else if ( horizontalSize == .compact ) {
            // Phone in Portrait mode
            VStack {
                OHashMap().environmentObject(state)
                InfoGrid().environmentObject(state)
            }
        }
        else {
            // iPad or other larger device
            ZStack(alignment: .bottomTrailing) {
                OHashMap().environmentObject(state)
                InfoGrid().environmentObject(state).fixedSize()
            }
        }
                        
    }
    
}

#Preview {
    ContentView().previewInterfaceOrientation(.landscapeLeft)
}

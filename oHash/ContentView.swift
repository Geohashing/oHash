//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var blah = "blah blah blah"
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                Map()
                
                Text(blah)
                    .padding(50)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        action: {blah = "clicked gearshape icon" },
                        label: {Image(systemName: "gearshape")}
                    )
                }
                
                ToolbarItem(placement: .principal) {
                    Button("today") {
                        print("today tapped!")
                        blah = "clicked date"
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        action: {blah = "clicked bell icon" },
                        label: {Image(systemName: "bell")}
                    )
                    
                }
                
                
                
                
                
            }
        }
    }
        
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var hashDate = Date.now
    @State private var tapText = "no buttons tapped yet"
    @State private var tapPoint = CLLocationCoordinate2D.init()
    @State private var mapRegion = MKCoordinateRegion.init()
    
    @State private var retroHashMode = false
    var currentDays = ["Today", "Tomorrow", "Monday"]
    @State private var selectedCurrentDay = "Today"
    @State private var selectedRetroDay = Date.now
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                MapReader { proxy in
                    Map(interactionModes: [.pan, .zoom]){
                        GridLines(region: mapRegion)
                    }
                    .onTapGesture {
                        position in
                        tapText = "map tap"
                        tapPoint = proxy.convert(position, from: .local) ??  CLLocationCoordinate2D.init()
                    }
                    .onMapCameraChange(frequency: .continuous) { mapCameraUpdateContext in
                        mapRegion = mapCameraUpdateContext.region
                    }
                }
                Grid{
                    
                    Text("-123, 45")
                        .font(.largeTitle)
                    Text("-123,45678, 45.67890")
                    
                    Picker("Retrohash", selection: $retroHashMode) {
                        Text("Current").tag(false)
                        Text("Retrohash").tag(true)
                    }
                    .pickerStyle(.segmented)
                    
                    if (retroHashMode) {
                        GridRow {
                            Text("Date").gridColumnAlignment(.trailing)
                            DatePicker(
                                "Please enter a date",
                                selection: $selectedRetroDay,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            .gridColumnAlignment(.leading).font(.title2)
                        }
                    } else { // regular, current dates mode
                        GridRow {
                            Text("Today").gridColumnAlignment(.trailing)
                            Text(Date.now.formatted(date: .abbreviated, time:.omitted)).gridColumnAlignment(.leading).font(.title2)
                        }
                        
                    } // end if retroHashMode
                    
                    
                    Divider().gridCellUnsizedAxes(.horizontal)
                    
                    GridRow{
                        Text("Distance").gridColumnAlignment(.trailing)
                        Text("123 km").gridColumnAlignment(.leading).font(.title2)
                    }
                    
                    GridRow{
                        Text("Closest").gridColumnAlignment(.trailing)
                        Text("12 m").gridColumnAlignment(.leading).font(.title2)
                    }
                    
                    Divider().gridCellUnsizedAxes(.horizontal)
                    
                }//.padding(10)
                
            }
            
            .toolbar {
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    Menu(content: {
                        
                        Button(
                            action: {tapText = "tapped 1.circle" },
                            label: {
                                Image(systemName: "1.circle")
                                Text("One")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 2.circle" },
                            label: {
                                Image(systemName: "2.circle")
                                Text("Two")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 3.circle" },
                            label: {
                                Image(systemName: "3.circle")
                                Text("Three")
                            }
                        )
                        
                    },
                         label: {Image(systemName: "gearshape")}
                    )
                    
                    Spacer()
                    
                    
                    Button(
                        action: {tapText = "tapped Location" },
                        label: {
                            Image(systemName: "location.fill").font(.largeTitle)
                        }
                    )
                    
                    Spacer()
                    
                    Menu(content: {
                        
                        Button(
                            action: {tapText = "tapped doc.richtext" },
                            label: {
                                Image(systemName: "doc.richtext")
                                Text("Poster")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped newspaper" },
                            label: {
                                Image(systemName: "newspaper")
                                Text("Wiki Page")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped map icon" },
                            label: {
                                Image(systemName: "map")
                                Text("Apple Maps")
                            }
                        )
                        Button(
                            action: {tapText = "tapped map icon" },
                            label: {
                                Image(systemName: "map")
                                Text("Google Maps")
                            }
                        )
                        
                    },
                         label:{Image(systemName: "square.and.arrow.up")})
                    
                }
                
            }
        }
    }
    
}

#Preview {
    ContentView().previewInterfaceOrientation(.portrait)
}

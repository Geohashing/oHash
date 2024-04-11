//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var state = OHashState()
    
    // temporary vars:
    @State private var tapText = "no buttons tapped yet"
    var currentDays = ["Today", "Tomorrow", "Monday"]
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                MapReader { proxy in
                    Map(
                        initialPosition: MapCameraPosition.region(state.mapRegion),
                        interactionModes: [.pan, .zoom, .rotate]
                    ){
                        GridLines(region: state.mapRegion)
                    }
                    .onTapGesture {
                        position in
                        
                        state.selectedGraticule
                        = Graticule(coords: proxy.convert(position, from: .local) ??  CLLocationCoordinate2D.init())
                        tapText = "map tap on \(state.selectedGraticule.latitude), \(state.selectedGraticule.longitude)"
                    }
                    .onMapCameraChange(frequency: .continuous) { mapCameraUpdateContext in
                        state.mapRegion = mapCameraUpdateContext.region
                    }
                }
                Grid{
                    
                    Text("\(state.selectedGraticule.latitude), \(state.selectedGraticule.longitude)")
                        .font(.largeTitle)
                    Text("-123,45678, 45.67890")
                    
                    Picker("Retrohash", selection: state.$retroHashModeFlag) {
                        Text("Current").tag(false)
                        Text("Retrohash").tag(true)
                    }
                    .pickerStyle(.segmented)
                    
                    if (state.retroHashModeFlag) {
                        GridRow {
                            Text("Date").gridColumnAlignment(.trailing)
                            DatePicker(
                                "Please enter a date",
                                selection: state.$selectedRetroDate,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                            .gridColumnAlignment(.leading).font(.title2)
                        }
                    } else { // regular, current dates mode
                        GridRow {
                            Text("Today").gridColumnAlignment(.trailing)
                            Text(state.selectedCurrentDate.formatted(date: .abbreviated, time:.omitted)).gridColumnAlignment(.leading).font(.title2)
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
                                Text(
                                    (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "no app vers"
                                )
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 2.circle" },
                            label: {
                                Image(systemName: "2.circle")
                                Text(
                                    (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? "no build no"
                                )
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 3.circle" },
                            label: {
                                Image(systemName: "3.circle")
                                Text(
                                    (Bundle.main.object(forInfoDictionaryKey: "baseDowJonesURL") as? String) ?? "no hash URL"
                                )
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 4.circle" },
                            label: {
                                Image(systemName: "4.circle")
                                Text(
                                    (Bundle.main.object(forInfoDictionaryKey: "gitCommit") as? String) ?? "no Git commit"
                                )
                            }
                        )
                        Button(
                            action: {tapText = "tapped 5.circle" },
                            label: {
                                Image(systemName: "5.circle")
                                Text(
                                    tapText
                                )
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
                            action: {tapText = "tapped apple map icon" },
                            label: {
                                Image(systemName: "map")
                                Text("Apple Maps")
                            }
                        )
                        Button(
                            action: {tapText = "tapped google map icon" },
                            label: {
                                Image(systemName: "map")
                                Text("Google Maps")
                            }
                        )
                        Button(
                            action: {tapText = "tapped osm map icon" },
                            label: {
                                Image(systemName: "map")
                                Text("Open Street Maps")
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

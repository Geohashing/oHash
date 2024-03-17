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
    
    var colors = ["Retro", "Yesterday", "Today", "Tomorrow","Monday"]
    @State private var selectedColor = "Today"
    
    
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

                    Divider().gridCellUnsizedAxes(.horizontal)

                    GridRow{
//                        Text("Today:").gridColumnAlignment(.trailing).font(.title2)
                        Picker("Please choose a color", selection: $selectedColor) {
                            ForEach(colors, id: \.self) {
                                Text($0)
                            }
                        }                        .gridColumnAlignment(.trailing)
                        Text("1 Jan 2000").gridColumnAlignment(.leading).font(.title2)
                    }

                    Divider().gridCellUnsizedAxes(.horizontal)

                    GridRow{
                        Text("Current Distance:").gridColumnAlignment(.trailing)
                        Text("123 km").gridColumnAlignment(.leading).font(.title2)
                    }
                    
                    GridRow{
                        Text("Closest Distance:").gridColumnAlignment(.trailing)
                        Text("12 m").gridColumnAlignment(.leading).font(.title2)
                    }

                    Divider().gridCellUnsizedAxes(.horizontal)


//                    GridRow{
//                        Text("Centre:")
//                        Text(mapRegion.center.latitude.formatted(.number.precision(.fractionLength(2))))
//                        Text(mapRegion.center.longitude.formatted(.number.precision(.fractionLength(2))))
//                    }                    .gridColumnAlignment(.trailing)
//                    
//                    GridRow{
//                        Text("Span:")
//                        Text(mapRegion.span.latitudeDelta.formatted(.number.precision(.fractionLength(3))))
//                        Text(mapRegion.span.longitudeDelta.formatted(.number.precision(.fractionLength(3))))
//                    }                    .gridColumnAlignment(.trailing)
//                    
//                    Divider().gridCellUnsizedAxes(.horizontal)
//                    GridRow{
//                        Text("Tap Point:")
//                        Text(tapPoint.latitude.formatted(.number.precision(.fractionLength(2))))
//                        Text(tapPoint.longitude.formatted(.number.precision(.fractionLength(2))))
//                    }                    .gridColumnAlignment(.trailing)
//                    Text(tapText)
//                    Divider().gridCellUnsizedAxes(.horizontal)
//                    Text(hashDate, style: .date)
                    
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
                    
                    
                    Menu(content: {
                        
                        Button(
                            action: {tapText = "tapped 1.square" },
                            label: {
                                Image(systemName: "1.square")
                                Text("One")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 2.square" },
                            label: {
                                Image(systemName: "2.square")
                                Text("Two")
                            }
                        )
                        
                        Button(
                            action: {tapText = "tapped 3.square" },
                            label: {
                                Image(systemName: "3.square")
                                Text("Three")
                            }
                        )
                        
                    },
                         label: {Image(systemName: "location.fill").font(.title)}
                    )

                    Spacer()

                    Menu(content: {
                        
                        Button(
                            action: {tapText = "tapped doc.richtext" },
                            label: {Image(systemName: "doc.richtext")}
                        )
                        
                        Button(
                            action: {tapText = "tapped newspaper" },
                            label: {Image(systemName: "newspaper")}
                        )
                        
                        Button(
                            action: {tapText = "tapped map icon" },
                            label: {Image(systemName: "map")}
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

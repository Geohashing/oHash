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
    
    
    let position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15)
        )
    )
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                MapReader { proxy in
                    Map(){
                        //                        OhGrid.latLongLines(region:mapRegion)
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
                    
                    GridRow{
                        Text("Centre:")
                        Text(mapRegion.center.latitude.formatted(.number.precision(.fractionLength(2))))
                        Text(mapRegion.center.longitude.formatted(.number.precision(.fractionLength(2))))
                    }                    .gridColumnAlignment(.trailing)
                    
                    GridRow{
                        Text("Span:")
                        Text(mapRegion.span.latitudeDelta.formatted(.number.precision(.fractionLength(3))))
                        Text(mapRegion.span.longitudeDelta.formatted(.number.precision(.fractionLength(3))))
                    }                    .gridColumnAlignment(.trailing)
                    
                    Divider().gridCellUnsizedAxes(.horizontal)
                    GridRow{
                        Text("Tap Point:")
                        Text(tapPoint.latitude.formatted(.number.precision(.fractionLength(2))))
                        Text(tapPoint.longitude.formatted(.number.precision(.fractionLength(2))))
                    }                    .gridColumnAlignment(.trailing)
                    Text(tapText)
                    Divider().gridCellUnsizedAxes(.horizontal)
                    Text(hashDate, style: .date)
                    
                }.padding(20)
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button(
                        action: {
                            hashDate = Calendar.current.date(
                                byAdding: DateComponents(day: -1), to: hashDate
                            ) ?? hashDate
                        },
                        label: {Image(systemName: "chevron.left")}
                    )
                    
                }
                
                ToolbarItem(placement: .principal) {
                    
                    DatePicker(
                        "What date do you want to check?",
                        selection: $hashDate,
                        displayedComponents: .date
                    ).labelsHidden()
                    
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button(
                        action: {
                            hashDate = Calendar.current.date(
                                byAdding: DateComponents(day: +1), to: hashDate
                            ) ?? hashDate
                        },
                        label: {Image(systemName: "chevron.right")}
                    )

                    
                    
                }
                
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
                        action: {tapText = "tapped a.square" },
                        label: {Image(systemName: "a.square")}
                    )
                    Spacer()
                    
                    Button(
                        action: {tapText = "tapped b.square" },
                        label: {Image(systemName: "b.square")}
                    )
                    
                    Spacer()
                    Button(
                        action: {tapText = "tapped c.square" },
                        label: {Image(systemName: "c.square")}
                    ).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
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
                         label: {Image(systemName: "bell")}
                    )

                    
                }
                
            }
        }
    }
    
}

#Preview {
    ContentView().previewInterfaceOrientation(.landscapeLeft)
}

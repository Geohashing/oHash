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
                    Map(
//            TODO  remove this            initialPosition:position
                    ){
                        OhGrid.latLongLines(
                            latitudeDelta:mapRegion.span.latitudeDelta, longitudeDelta:mapRegion.span.longitudeDelta
                        )
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
                VStack{
                    Text(
                        mapRegion.center.latitude.formatted(.number.precision(.fractionLength(2)))
                        + ", " +
                        mapRegion.center.longitude.formatted(.number.precision(.fractionLength(2)))
                    )
                    
                    Text(
                        mapRegion.span.latitudeDelta.formatted(.number.precision(.fractionLength(6)))
                        + ", " +
                        mapRegion.span.longitudeDelta.formatted(.number.precision(.fractionLength(6)))
                    )
                    Text(tapText)
                    Text(
                        tapPoint.latitude.formatted(.number.precision(.fractionLength(2)))
                        + ", " +
                        tapPoint.longitude.formatted(.number.precision(.fractionLength(2)))
                    )
                    Text(hashDate, style: .date)
                }.padding(20)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
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
                    
                }
                
                ToolbarItem(placement: .principal) {
                                        
                    DatePicker(
                        "What date do you want to check?",
                        selection: $hashDate,
                        displayedComponents: .date
                    ).labelsHidden()
                                        
                }

                ToolbarItem(placement: .topBarTrailing) {
                    
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
                        
                    }, label: {Image(systemName: "bell")}
                    )

                    
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    
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
                    )
                    Spacer()
                    Button(
                        action: {tapText = "tapped d.square" },
                        label: {Image(systemName: "d.square")}
                    ).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button(
                        action: {tapText = "tapped e.square" },
                        label: {Image(systemName: "e.square")}
                    )
                                        
                }
                
            }
        }
    }
        
}

#Preview {
    ContentView().previewInterfaceOrientation(.landscapeLeft)
}

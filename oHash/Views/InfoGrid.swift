//
//  InfoGrid.swift
//  oHash
//
//  Created by Brendan White on 14/4/2024.
//

import SwiftUI

struct InfoGrid: View {
    @EnvironmentObject var state:OHashState
    
    var body: some View {

        Grid{
            
            // Graticule Section
            Text("\(state.selectedGraticule.latitude), \(state.selectedGraticule.longitude)")
                .font(.largeTitle)
            Text("-123,45678, 45.67890")
            
            Divider()
            
            // Distance Section
            GridRow{
                Text("Distance").gridColumnAlignment(.trailing)
                Text("123 km").gridColumnAlignment(.leading).font(.title2)
            }
            
            GridRow{
                Text("Closest").gridColumnAlignment(.trailing)
                Text("12 m").gridColumnAlignment(.leading).font(.title2)
            }
            
            Divider()
            
            // Date Section - Date
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
            
            
            // Date Section - Picker
            Picker("Retrohash", selection: state.$retroHashModeFlag) {
                Text("Retrohash").tag(true)
                Text("Current").tag(false)
            }
            .pickerStyle(.segmented)
            .fixedSize()
            
            
            
            Divider()
            
            HStack() {
                
                Menu(content: {
                    
                    Button(
                        action: {state.tapText = "tapped 1.circle" },
                        label: {
                            Image(systemName: "1.circle")
                            Text(
                                (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? "no app vers"
                            )
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped 2.circle" },
                        label: {
                            Image(systemName: "2.circle")
                            Text(
                                (Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String) ?? "no build no"
                            )
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped 3.circle" },
                        label: {
                            Image(systemName: "3.circle")
                            Text(
                                (Bundle.main.object(forInfoDictionaryKey: "baseDowJonesURL") as? String) ?? "no hash URL"
                            )
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped 4.circle" },
                        label: {
                            Image(systemName: "4.circle")
                            Text(
                                (Bundle.main.object(forInfoDictionaryKey: "gitCommit") as? String) ?? "no Git commit"
                            )
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped 5.circle" },
                        label: {
                            Image(systemName: "5.circle")
                            Text(
                                state.tapText
                            )
                        }
                    )
                    
                },
                     label: {Image(systemName: "gearshape")}
                )
                .padding(.horizontal,30)
                
                
                Spacer()
                
                
                Button(
                    action: {state.tapText = "tapped Location" },
                    label: {
                        Image(systemName: "location.fill").font(.largeTitle)
                    }
                )
                
                Spacer()
                
                Menu(content: {
                    
                    Button(
                        action: {state.tapText = "tapped doc.richtext" },
                        label: {
                            Image(systemName: "doc.richtext")
                            Text("Poster")
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped newspaper" },
                        label: {
                            Image(systemName: "newspaper")
                            Text("Wiki Page")
                        }
                    )
                    
                    Button(
                        action: {state.tapText = "tapped apple map icon" },
                        label: {
                            Image(systemName: "map")
                            Text("Apple Maps")
                        }
                    )
                    Button(
                        action: {state.tapText = "tapped google map icon" },
                        label: {
                            Image(systemName: "map")
                            Text("Google Maps")
                        }
                    )
                    Button(
                        action: {state.tapText = "tapped osm map icon" },
                        label: {
                            Image(systemName: "map")
                            Text("Open Street Maps")
                        }
                    )
                    
                },
                     label:{Image(systemName: "square.and.arrow.up")}
                )
                .padding(.horizontal,30)
                
                
            }
            .padding(.top,10)
            
        }
        .background(.windowBackground)
                
    }
    
}

#Preview {
    InfoGrid()
}

//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var date = Date.now
    @State private var blah = "no action yet"
    
    var body: some View {
        NavigationStack {
            
            VStack {
                Map()
                VStack{
                    Text(blah)
                    Text(date, style: .date)
                }.padding(50)
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Menu(content: {
                        
                        Button(
                            action: {blah = "clicked 1.circle" },
                            label: {
                                Image(systemName: "1.circle")
                                Text("One")
                            }
                        )
                        
                        Button(
                            action: {blah = "clicked 2.circle" },
                            label: {
                                Image(systemName: "2.circle")
                                Text("Two")
                            }
                        )
                        
                        Button(
                            action: {blah = "clicked 3.circle" },
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
                        selection: $date,
                        displayedComponents: .date
                    ).labelsHidden()
                    
                }

                ToolbarItem(placement: .topBarTrailing) {
                    
                    Menu(content: {
                        
                        Button(
                            action: {blah = "clicked 1.square" },
                            label: {
                                Image(systemName: "1.square")
                                Text("One")
                            }
                        )
                        
                        Button(
                            action: {blah = "clicked 2.square" },
                            label: {
                                Image(systemName: "2.square")
                                Text("Two")
                            }
                        )
                        
                        Button(
                            action: {blah = "clicked 3.square" },
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
                        action: {blah = "clicked a.square" },
                        label: {Image(systemName: "a.square")}
                    )
                    Spacer()
                    Button(
                        action: {blah = "clicked b.square" },
                        label: {Image(systemName: "b.square")}
                    )
                    Spacer()
                    Button(
                        action: {blah = "clicked c.square" },
                        label: {Image(systemName: "c.square")}
                    )
                    Spacer()
                    Button(
                        action: {blah = "clicked d.square" },
                        label: {Image(systemName: "d.square")}
                    ).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button(
                        action: {blah = "clicked e.square" },
                        label: {Image(systemName: "e.square")}
                    )
                                        
                }
                
            }
        }
    }
        
}

#Preview {
    ContentView()
}

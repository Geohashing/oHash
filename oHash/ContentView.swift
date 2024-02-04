//
//  ContentView.swift
//  oHash
//
//  Created by Brendan White on 4/2/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        VStack {

            HStack{
                
                Button(
                    action: {print("clicked gearshape icon") },
                    label: {Image(systemName: "gearshape")}
                )
                Spacer()
                
                Button(
                    action: {print("clicked arrowshape.left icon") },
                    label: {Image(systemName: "arrowshape.left")}
                )

                Text("Today")
                
                Button(
                    action: {print("clicked arrowshape.right icon") },
                    label: {Image(systemName: "arrowshape.right")}
                )

                Spacer()
                Button(
                    action: {print("clicked bell icon") },
                    label: {Image(systemName: "bell")}
                )

            }
            .padding([.leading,.trailing], 20)

            Map()

            Text("Graticule Info Section")
                .padding(50)
            

        }
    }
}

#Preview {
    ContentView()
}

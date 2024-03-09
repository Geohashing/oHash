//
//  DateSection.swift
//  oHash
//
//  Created by Brendan White on 9/3/2024.
//

import SwiftUI

struct DateSection: View {
    @Binding var hashDate:Date
    
    var body: some View {
        
        HStack{
            
            Button(
                action: {
                    hashDate = Calendar.current.date(
                        byAdding: DateComponents(day: -1), to: hashDate
                    ) ?? hashDate
                },
                label: {Image(systemName: "chevron.backward")}
            ) // Previous date
            
            Spacer()
            
            DatePicker(
                "What date do you want to check?",
                selection: $hashDate,
                displayedComponents: .date
            ).labelsHidden()
            
            Spacer()
            
            Button(
                action: {
                    hashDate = Calendar.current.date(
                        byAdding: DateComponents(day: +1), to: hashDate
                    ) ?? hashDate
                },
                label: {Image(systemName: "chevron.forward")}
            ) // Previous date
            
        }
        
    }
}

#Preview {
    ContentView().previewInterfaceOrientation(.portrait)
}
